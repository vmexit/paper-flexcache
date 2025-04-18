import os
import sys
import json
import numpy as np
import pandas as pd

currentdir=os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(currentdir))

def getrelative(df):
    dfrelative = pd.DataFrame()
    mindf = df.min(axis=1)
    for column in df.columns:
        dfrelative[column] = (1-df[column])/(1-mindf)
    dfrelative.fillna(1, inplace=True)
    return dfrelative  

file="systor-lun1-mrc.csv"
df = pd.read_csv(os.path.join(currentdir, file),header=0,index_col=0)
dfret = getrelative(df)
dfret.index.name = 'x'
dfret.reset_index(inplace=True)

df.index.name = 'x'
df.reset_index(inplace=True)
df.to_csv(currentdir+"/../data/systor-lun1-mrc.dat", sep=' ', index=False, float_format='%.3f')
dfret.to_csv(currentdir+"/../data/systor-lun1-retmrc.dat", sep=' ', index=False, float_format='%.3f')

file = "fiumrc.csv"
df = pd.read_csv(os.path.join(currentdir, file),header=0,index_col=0)
df.reset_index(inplace=True)
df.to_csv(currentdir+"/../data/fiumrc.dat", sep=' ', index=False, float_format='%.3f')