import os
import sys
import json
import numpy as np
import pandas as pd

currentdir=os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(currentdir))
dir = currentdir+"/totaloutput/withoutobjsize"
file = dir+"/cloudphysics/cloudphysics-0.03.csv"
dropcolumn=["Belady"]

def getrelative(df):
    dfrelative = pd.DataFrame()
    mindf = df.min(axis=1)
    for column in df.columns:
        dfrelative[column] = (1-df[column])/(1-mindf)
    dfrelative.fillna(1, inplace=True)
    return dfrelative  

targetpolicy=["accp4","S3FIFO","LIRS","ARC","WTinyLFU"]
out_column = ["FlexCache", "S3-FIFO", "ARC", "Cacheus", "LeCaR", "LIRS", "WTinyLFU", "GDSF"]

df = pd.read_csv(file,header=0,index_col=0)  # 或者你已有的 DataFrame
for col in dropcolumn:
    if col in df.columns:
        df.drop(col, axis=1, inplace=True)
df.columns = df.columns.str.replace("flex-0.10-0.05-1.00", "FlexCache")
df.columns = df.columns.str.replace("S3FIFO", "S3-FIFO")

dfret = getrelative(df)

dfret = dfret[out_column]
dfret.reset_index(inplace=True)
dfret.to_csv(currentdir+"/../data/violin.dat", sep=' ', index=False, float_format='%.3f')

#对每列从小到大排序
dfsort = dfret.apply(np.sort)
dfsort['index'] = range(1, len(dfsort['index'])+1)
#间隔5%选取dfsort中数据
dfs = pd.DataFrame()
for column in dfret.columns:
    dfs[column] = dfsort[column][::int(len(dfsort[column])/20)]
    
dfs.to_csv(currentdir+"/../data/violincdf.dat", sep=' ', index=False, float_format='%.3f')


