import os
import sys
import json
import numpy as np
import pandas as pd

currentdir=os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(currentdir))
dir = currentdir+"/outputdata"
outputdir = currentdir+"/../data/break"

targetpolicy=["accp4","accp4c","accp4p"]

result = {}
for bench in os.listdir(dir):
    benchdir = os.path.join(dir, bench)
    result[bench] = {}
    relative={"1": pd.DataFrame(),"5": pd.DataFrame(),"10": pd.DataFrame(),"50": pd.DataFrame()}
    for file in os.listdir(benchdir):
        name = os.path.splitext(file)[0]
        cachesize = float(name.split("-")[1])
        df = pd.read_csv(os.path.join(benchdir, file),header=0,index_col=0)
        df.drop("Belady", axis=1, inplace=True)
        mindf = df.min(axis=1)
        for column in df.columns:
            df[column] = (1 -df[column])/(1-mindf)
        df.fillna(1, inplace=True)
        df.sort_values(by="accp4", ascending=True, inplace=True)
        if len(df.index) > 100:
            dfsort = df.T
            dfsort.columns = range(1, len(dfsort.columns)+1)
            dfsort = dfsort.T
            dfsort.to_csv(outputdir+"/RHR"+bench+str(cachesize)+".dat", sep=' ', float_format='%.3f')

        continue
        df = df[targetpolicy]
        df["accp4c"] = (1-df["accp4c"]) / (1-df["accp4"])
        df["accp4p"] = (1-df["accp4p"]) / (1-df["accp4"])
        df.fillna(1, inplace=True)
        rhr = df.prod(axis=0)**(1/len(df))
        result[bench][cachesize] = rhr
        if len(df.index) > 100:
            #对每列从小到大排序
            dfsort = df.apply(np.sort)
            dfsort = dfsort.T
            dfsort.columns = range(1, len(dfsort.columns)+1)
            dfsort = dfsort.T
            dfsort.to_csv(outputdir+"/"+bench+str(cachesize)+".dat", sep=' ', float_format='%.3f')
            continue
            dfout = pd.DataFrame()
            dfout["P1"] = dfsort[int(len(dfsort.columns)*0.01)]
            dfout["P5"] = dfsort[int(len(dfsort.columns)*0.05)]
            dfout["P10"] = dfsort[int(len(dfsort.columns)*0.1)]
            dfout["P50"] = dfsort[int(len(dfsort.columns)*0.5)]
            dfout["P90"] = dfsort[int(len(dfsort.columns)*0.9)]
            dfout["P95"] = dfsort[int(len(dfsort.columns)*0.95)]
            dfout["P99"] = dfsort[int(len(dfsort.columns)*0.99)]
            dfout["average"] = rhr
            dfout.index.name = "policy"
            dfout.to_csv(outputdir+"/"+bench+str(cachesize)+".dat", sep=' ', float_format='%.3f')