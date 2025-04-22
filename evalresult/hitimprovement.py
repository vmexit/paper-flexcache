import os
import sys
import json
import numpy as np
import pandas as pd

currentdir=os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(currentdir))
dir = currentdir+"/outputdata"
outputdir = currentdir+"/../data/hitimp"
if not os.path.exists(outputdir):
    os.makedirs(outputdir)

dropcolumn=["Belady"]
#accp4 ARC Cacheus Clock FIFO FIFO-Merge GDSF Hyperbolic LHD LIRS LeCaR QDLP S3FIFO S4LRU TwoQ WTinyLFU
column = ["accp4", "ARC", "Cacheus", "Clock", "FIFO", "FIFO-Merge", "GDSF", "Hyperbolic", "LHD", "LIRS", "LeCaR", "QDLP", "S3FIFO", "S4LRU", "WTinyLFU", "TwoQ", "accp4c", "accp4p"]

def getrelative(df):
    dfrelative = pd.DataFrame()
    mindf = df.min(axis=1)
    mindf = df["FIFO"]
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
        #rhr = dfret.mean()
        rhr = dfret.prod(axis=0)**(1/len(dfret))
        result[bench][cachesize] = rhr - 1
  
    tmpres = result[bench]
    tmpres = pd.DataFrame(tmpres)
    tmpres.sort_index(axis=1, ascending=True, inplace=True)
    tmpres = tmpres.T
    tmpres.index.name = "cachesize"
    tmpres = tmpres[column]
    tmpres.to_csv(outputdir+"/"+bench+".dat", sep=' ', float_format='%.3f')

bench = [key for key in result.keys()]
print(bench)
for cachesize in result[bench[0]].keys():
    tmpres = pd.DataFrame()
    for bench in result.keys():
        tmpres[bench] = result[bench][cachesize]
    tmpres = tmpres.T
    tmpres.index.name = "benchmarks"
    tmpres = tmpres[column]
    tmpres.to_csv(outputdir+"/"+str(cachesize)+".dat", sep=' ', float_format='%.3f')
    
resultdf = pd.DataFrame(result)
print(resultdf)
print(resultdf.columns)
print(resultdf.index)