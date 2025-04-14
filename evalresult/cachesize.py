import os
import sys
import json
import numpy as np
import pandas as pd

currentdir=os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(currentdir))
dir = currentdir+"/outputdata"

bench = "cloudphysics"

dropcolumn=["Belady", "accp4c", "accp4p"]

def getrelative(df):
    dfrelative = pd.DataFrame()
    mindf = df.min(axis=1)
    for column in df.columns:
        dfrelative[column] = (1-df[column])/(1-mindf)
    dfrelative.fillna(1, inplace=True)
    return dfrelative    

benchdir = os.path.join(dir, bench)
result = pd.DataFrame()

for file in os.listdir(benchdir):
    #读取csv文件，第一行是列表名，第一列是索引
    df = pd.read_csv(os.path.join(benchdir, file),header=0,index_col=0)
    for col in dropcolumn:
        if col in df.columns:
            df.drop(col, axis=1, inplace=True)
    name = os.path.splitext(file)[0]
    cachesize = float(name.split("-")[1])
    dfret = getrelative(df)
    #求每列的几何平均数
    dfret = dfret.prod(axis=0)**(1/len(dfret))
    result[cachesize] = dfret
    #exit(0)
#按照列名排序
#result = result.T
result = result.sort_index(axis=1)
result = result.T
result.index.name = 'x'
result.reset_index(inplace=True)
result.to_csv(currentdir+"/../data/"+bench+".dat", sep=' ', index=False, float_format='%.3f')
print(result)

