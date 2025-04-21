import os
import sys
import json
import numpy as np
import pandas as pd

currentdir=os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(currentdir))
dir = currentdir+"/outputdata"
outputdir = currentdir+"/../data/RHR"
if not os.path.exists(outputdir):
    os.makedirs(outputdir)

dropcolumn=["Belady", "accp4c", "accp4p"]
#accp4 ARC Cacheus Clock FIFO FIFO-Merge GDSF Hyperbolic LHD LIRS LeCaR QDLP S3FIFO S4LRU TwoQ WTinyLFU
column = ["accp4", "ARC", "Cacheus", "Clock", "FIFO", "FIFO-Merge", "GDSF", "Hyperbolic", "LHD", "LIRS", "LeCaR", "QDLP", "S3FIFO", "S4LRU", "WTinyLFU", "TwoQ"]

def getrelative(df):
    dfrelative = pd.DataFrame()
    mindf = df.min(axis=1)
    for column in df.columns:
        dfrelative[column] = (1-df[column])/(1-mindf)
    dfrelative.fillna(1, inplace=True)
    return dfrelative  

result = {}
for bench in os.listdir(dir):
    benchdir = os.path.join(dir, bench)
    result[bench] = {}
    relative={"1": pd.DataFrame(),"5": pd.DataFrame(),"10": pd.DataFrame(),"50": pd.DataFrame()}
    for file in os.listdir(benchdir):
        name = os.path.splitext(file)[0]
        cachesize = float(name.split("-")[1])
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