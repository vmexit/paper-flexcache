import os
import sys
import json
import numpy as np
import pandas as pd

currentdir=os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(currentdir))
inputdir = currentdir+"/totaloutput"
outputdir = currentdir+"/../data/RHR"
if not os.path.exists(outputdir):
    os.makedirs(outputdir)

dropcolumn=["Belady", "QDLP"]
#accp4 ARC Cacheus Clock FIFO FIFO-Merge GDSF Hyperbolic LHD LIRS LeCaR QDLP S3FIFO S4LRU TwoQ WTinyLFU
column = ["flex-0.10-0.05-1.00", "S3FIFO", "ARC", "Cacheus", "LeCaR", "LIRS", "WTinyLFU", "GDSF", "Hyperbolic", "LHD", "S4LRU", "TwoQ", "Clock", "FIFO", "FIFO-Merge", "QDLP"]
column = ["FlexCache", "S3FIFO", "ARC", "Cacheus", "LeCaR", "LIRS", "WTinyLFU", "GDSF", "Hyperbolic", "LHD", "S4LRU", "TwoQ", "Clock", "FIFO", "FIFO-Merge"]


def getrelative(df):
    dfrelative = pd.DataFrame()
    mindf = df.min(axis=1)
    for column in df.columns:
        dfrelative[column] = (1-df[column])/(1-mindf)
    dfrelative.fillna(1, inplace=True)
    return dfrelative  

def getdfRHR(filepath, bench, cachesize):
    df = pd.read_csv(filepath,header=0,index_col=0)
    #keeyp rows with any value < 0.9
    df = df[(df < 0.99).all(1)]
    df = df[(df < 0.95).any(axis=1)]
    #df = df[(df < 0.9).all(1)]
    for col in dropcolumn:
        if col in df.columns:
            df.drop(col, axis=1, inplace=True)
    dfret = getrelative(df)
    dfret.columns = dfret.columns.str.replace("flex-0.10-0.05-1.00", "FlexCache")
    rhr = dfret.prod(axis=0)**(1/len(dfret))
    return dfret, rhr

def storeCDFTail(dfret, outputdir, bench, cachesize, rhr):
    dfsort = dfret.apply(np.sort)
    dfsort = dfsort[column]
    dfsort = dfsort.T
    dfsort.columns = range(1, len(dfsort.columns)+1)
    dfout = pd.DataFrame()
    dfout["P1"] = dfsort[int(len(dfsort.columns)*0.01)]
    dfout["P5"] = dfsort[int(len(dfsort.columns)*0.05)]
    dfout["P10"] = dfsort[int(len(dfsort.columns)*0.1)]
    dfout["P50"] = dfsort[int(len(dfsort.columns)*0.5)]
    dfout["average"] = rhr
    dfout.index.name = "policy"
    dfout.to_csv(outputdir+"/"+bench+str(cachesize)+".dat", sep=' ', float_format='%.3f')
    
def storeRHR(df, outputdir, bench):
    tmpres = df
    tmpres.sort_index(axis=1, ascending=True, inplace=True)
    tmpres = tmpres.T
    tmpres.index.name = "cachesize"
    tmpres = tmpres[column]
    tmpres.to_csv(outputdir+"/"+bench+".dat", sep=' ', float_format='%.3f')
    
def performance(df):
    dfsort = df.apply(np.sort)
    dfsort = dfsort[column]
    target = [1,0.99,0.95,0.90]
    dfper = pd.DataFrame(columns=df.columns)
    for col in dfsort.columns:
        for t in target:
            dfper.at[str(t*100)+"%", col] = (dfsort[col] >= t).sum()/len(dfsort[col])
    dfper = dfper[column]
    print(dfper)
    
    
def calculate(inputdir, outputdir):
    result = {}
    resultB = {}
    total = {}
    totalB = {}
    for bench in os.listdir(inputdir):
        benchdir = os.path.join(inputdir, bench)
        result[bench] = {}
        resultB[bench] = {}
        for file in os.listdir(benchdir):
            name = os.path.splitext(file)[0]
            cachesize = float(name.split("-")[-1])
            dfret, rhr = getdfRHR(os.path.join(benchdir, file), bench, cachesize)
            if "byte" in name:
                resultB[bench][cachesize] = rhr
                if cachesize not in totalB:
                    totalB[cachesize] = dfret
                else:
                    totalB[cachesize] = pd.concat([totalB[cachesize], dfret])
                if len(dfret.index) > 100:
                    storeCDFTail(dfret, outputdir, bench+"B", cachesize, rhr)
                    print(bench, cachesize)
                    performance(dfret)
            else:
                continue
                result[bench][cachesize] = rhr
                if cachesize not in total:
                    total[cachesize] = dfret
                else:
                    total[cachesize] = pd.concat([total[cachesize], dfret])
                if len(dfret.index) > 100:
                    storeCDFTail(dfret, outputdir, bench, cachesize, rhr)
        #storeRHR(pd.DataFrame(result[bench]), outputdir, bench)
        storeRHR(pd.DataFrame(resultB[bench]), outputdir, bench+"B")
    for cachesize in total:
        rhr = (total[cachesize].prod(axis=0))**(1/len(total[cachesize]))
        #storeCDFTail(total[cachesize], outputdir, "total", cachesize, rhr)
    for cachesize in totalB:
        rhr = (totalB[cachesize].prod(axis=0))**(1/len(totalB[cachesize]))
        storeCDFTail(totalB[cachesize], outputdir, "totalB", cachesize, rhr)
        print(cachesize)
        performance(totalB[cachesize])
        
        
for subdir in os.listdir(inputdir):
    subinputdir = os.path.join(inputdir, subdir)
    if os.path.isdir(subinputdir):
        if not os.path.exists(outputdir+"/"+subdir):
            os.makedirs(outputdir+"/"+subdir)
        print("start "+subdir)
        calculate(subinputdir, outputdir+"/"+subdir)
        print("finish "+subdir)
        
exit(0)
result = {}
for bench in os.listdir(dir):
    benchdir = os.path.join(dir, bench)
    result[bench] = {}
    relative={"1": pd.DataFrame(),"5": pd.DataFrame(),"10": pd.DataFrame(),"50": pd.DataFrame()}
    for file in os.listdir(benchdir):
        name = os.path.splitext(file)[0]
        cachesize = float(name.split("-")[-1])
        df = pd.read_csv(os.path.join(benchdir, file),header=0,index_col=0)
        for col in dropcolumn:
            if col in df.columns:
                df.drop(col, axis=1, inplace=True)
        dfret = getrelative(df)
        rhr = dfret.prod(axis=0)**(1/len(dfret))
        result[bench][cachesize] = rhr
        if len(dfret.index) > 100:
            #对每列从小到大排序
            dfsort = dfret.apply(np.sort)
            dfsort = dfsort[column]
            dfsort.columns = dfsort.columns.str.replace("flex-0.10-0.05-1.00", "FlexCache")
            dfsort = dfsort.T
            dfsort.columns = range(1, len(dfsort.columns)+1)
            dfout = pd.DataFrame()
            dfout["P1"] = dfsort[int(len(dfsort.columns)*0.01)]
            dfout["P5"] = dfsort[int(len(dfsort.columns)*0.05)]
            dfout["P10"] = dfsort[int(len(dfsort.columns)*0.1)]
            dfout["P50"] = dfsort[int(len(dfsort.columns)*0.5)]
            dfout["average"] = rhr
            dfout.index.name = "policy"
            dfout.to_csv(outputdir+"/"+bench+str(cachesize)+".dat", sep=' ', float_format='%.3f')
            '''
            relative["1"][cachesize] = dfsort[int(len(dfsort.columns)*0.01)]
            relative["5"][cachesize] = dfsort[int(len(dfsort.columns)*0.05)]
            relative["10"][cachesize] = dfsort[int(len(dfsort.columns)*0.1)]
            relative["50"][cachesize] = dfsort[int(len(dfsort.columns)*0.5)]
    if len(relative["1"].columns) > 0:
        for key in relative:
            relative[key].sort_index(axis=1, ascending=True, inplace=True)
            relative[key] = relative[key].T
            relative[key].index.name = "cachesize"
            relative[key].to_csv(outputdir+"/"+bench+key+".dat", sep=' ', float_format='%.3f')
     '''       
    tmpres = result[bench]
    tmpres = pd.DataFrame(tmpres)
    tmpres.sort_index(axis=1, ascending=True, inplace=True)
    tmpres = tmpres.T
    tmpres.index.name = "cachesize"
    tmpres = tmpres[column]
    tmpres.to_csv(outputdir+"/"+bench+".dat", sep=' ', float_format='%.3f')

    
resultdf = pd.DataFrame(result)
print(resultdf)