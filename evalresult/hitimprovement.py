import os
import sys
import json
import numpy as np
import pandas as pd

currentdir=os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(currentdir))
inputdir = currentdir+"/totaloutput"
outputdir = currentdir+"/../data/hitimp"
if not os.path.exists(outputdir):
    os.makedirs(outputdir)

dropcolumn=["Belady", "QDLP"]
#accp4 ARC Cacheus Clock FIFO FIFO-Merge GDSF Hyperbolic LHD LIRS LeCaR QDLP S3FIFO S4LRU TwoQ WTinyLFU
out_column = ["accp4", "ARC", "Cacheus", "Clock", "FIFO", "FIFO-Merge", "GDSF", "Hyperbolic", "LHD", "LIRS", "LeCaR", "QDLP", "S3FIFO", "S4LRU", "WTinyLFU", "TwoQ", "accp4c", "accp4p"]
out_column = ["FlexCache", "S3-FIFO", "ARC", "Cacheus", "LeCaR", "LIRS", "WTinyLFU", "GDSF", "Hyperbolic", "LHD", "S4LRU", "TwoQ", "Clock", "FIFO", "FIFO-Merge"]
out_column = ["FlexCache", "S3-FIFO", "ARC", "Cacheus", "LeCaR", "LIRS", "WTinyLFU", "GDSF"]
out_row = ["systor", "metaCDN", "twitter", "fiu", "alibabaBlock", "msr", "tencentPhoto", "tencentBlock", "cloudphysics", "metaKV", "wikimedia"]
out_row = ["twitter", "metaKV", "metaCDN", "tencentPhoto", "wikimedia", "tencentBlock", "systor", "fiu", "msr", "alibabaBlock", "cloudphysics"]
out_row_rename = ["Twitter", "MetaKV", "MetaCDN", "TencentPhoto", "Wikimedia", "Tencent", "Systor", "fiu", "MSR", "Alibaba", "CloudPhysics"]

def getrelativehr(df):
    dfrelative = pd.DataFrame()
    mindf = df.min(axis=1)
    mindf = df["LRU"]
    for column in df.columns:
        dfrelative[column] = (1-df[column])/(1-mindf)
    dfrelative.fillna(1, inplace=True)
    return dfrelative  

def getrelativemr(df):
    dfrelative = pd.DataFrame()
    mindf = df.min(axis=1)
    mindf = df["FIFO"]
    for column in df.columns:
        #dfrelative[column] = (mindf-df[column])/(mindf)
        numerator = mindf - df[column]
        # 条件：mindf < df[column]
        condition = mindf < df[column]
        # 默认分母是 mindf
        denominator = mindf.copy()
        # 在条件满足时，用 df[column] 替换分母
        denominator = np.where(condition, df[column], mindf)
        # 计算结果
        dfrelative[column] = numerator / denominator
    dfrelative.fillna(0, inplace=True)
    return dfrelative  

def readfile(filepath):
    df = pd.read_csv(filepath,header=0,index_col=0)
    df = df[(df < 0.999).all(1)]
    for col in dropcolumn:
        if col in df.columns:
            df.drop(col, axis=1, inplace=True)
    df.columns = df.columns.str.replace("flex-0.10-0.05-1.00", "FlexCache")
    df.columns = df.columns.str.replace("S3FIFO", "S3-FIFO")
    dfret = getrelativehr(df)
    rhr = dfret.prod(axis=0)**(1/len(dfret))
    rhr = rhr - 1
    #dfret = getrelativemr(df)
    #rhr = dfret.mean()
    return dfret, rhr
   
def storeRHR(df, outputdir, bench):
    tmpres = df
    tmpres.sort_index(axis=1, ascending=True, inplace=True)
    tmpres = tmpres.T
    tmpres.index.name = "cachesize"
    tmpres = tmpres[out_column]
    tmpres.to_csv(outputdir+"/"+bench+".dat", sep=' ', float_format='%.3f')
    
def find_best(result):
    bestcounter = {}
    for bench in result.keys():
        for cachesize in result[bench].keys():
            df = result[bench][cachesize]
            maxidx = df.idxmax()
            if maxidx not in bestcounter:
                bestcounter[maxidx] = 0
            bestcounter[maxidx] += 1
    print(bestcounter)
    
     
def calculate(inputdir, outputdir):
    resultB = {}
    for bench in os.listdir(inputdir):
        benchdir = os.path.join(inputdir, bench)
        resultB[bench] = {}
        for file in os.listdir(benchdir):
            name = os.path.splitext(file)[0]
            cachesize = float(name.split("-")[-1])
            if "byte" in name:
                dfret, rhr = readfile(os.path.join(benchdir, file))
                resultB[bench][cachesize] = rhr
            else:
                continue
        storeRHR(pd.DataFrame(resultB[bench]), outputdir, bench+"B")

    bench = [key for key in resultB.keys()]
    for cachesize in resultB[bench[0]].keys():
        tmpres = pd.DataFrame()
        for bench in resultB.keys():
            tmpres[bench] = resultB[bench][cachesize]
        #print(cachesize, tmpres.idxmax())
        tmpres = tmpres[out_row]
        tmpres.columns = [out_row_rename[out_row.index(x)] for x in tmpres.columns]
        tmpres = tmpres.T
        tmpres.index.name = "benchmarks"
        tmpres = tmpres[out_column]
        tmpres.to_csv(outputdir+"/"+str(cachesize)+".dat", sep=' ', float_format='%.3f')
    #find_best(resultB)
   
for subdir in os.listdir(inputdir):
    subinputdir = os.path.join(inputdir, subdir)
    if os.path.isdir(subinputdir):
        if not os.path.exists(outputdir+"/"+subdir):
            os.makedirs(outputdir+"/"+subdir)
        print("start "+subdir)
        calculate(subinputdir, outputdir+"/"+subdir)
        print("finish "+subdir)         
        
exit(0)
