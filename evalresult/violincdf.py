import os
import sys
import json
import numpy as np
import pandas as pd

currentdir=os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(currentdir))
dir = currentdir+"/outputdata"
file = dir+"/cloudphysics/cloudphysics-0.03.csv"
dropcolumn=["Belady", "accp4c", "accp4p"]

def getrelative(df):
    dfrelative = pd.DataFrame()
    mindf = df.min(axis=1)
    for column in df.columns:
        dfrelative[column] = (1-df[column])/(1-mindf)
    dfrelative.fillna(1, inplace=True)
    return dfrelative  

targetpolicy=["accp4","S3FIFO","LIRS","ARC","WTinyLFU"]

df = pd.read_csv(file,header=0,index_col=0)  # 或者你已有的 DataFrame
for col in dropcolumn:
    if col in df.columns:
        df.drop(col, axis=1, inplace=True)

dfret = getrelative(df)

dfret = dfret[targetpolicy]
dfret.reset_index(inplace=True)
dfret.to_csv(currentdir+"/../data/violin.dat", sep=' ', index=False, float_format='%.3f')

#对每列从小到大排序

dfsort = dfret.apply(np.sort)
dfsort.to_csv(currentdir+"/../data/violincdf.dat", sep=' ', index=False, float_format='%.3f')


