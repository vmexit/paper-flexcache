import os
import sys
import json
import numpy as np
import pandas as pd

currentdir=os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(currentdir))
inputfile="io_traces.ns2.oracleGeneral.zst.popularity_pair"
def readfile(inputfile):
    df = pd.read_csv(inputfile, sep=" ", header=None)
    #change column name
    df.columns = ["freq", "num", "average"]
    return df
    
df = readfile(os.path.join(currentdir, inputfile))
df["numcdf"] = df["num"].cumsum()
df.to_csv(currentdir+"/../data/pop.dat", sep=' ', index=False, float_format='%.3f')

inputfile="cluster16.oracleGeneral.zst.popularity_pair"
df = readfile(os.path.join(currentdir, inputfile))
df["numcdf"] = df["num"].cumsum()
df.to_csv(currentdir+"/../data/pop2.dat", sep=' ', index=False, float_format='%.3f')