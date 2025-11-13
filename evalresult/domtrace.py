import os
import sys
import json
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import matplotlib.colors as colors


currentdir=os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(currentdir))
inputdir = currentdir+"/totaloutput/withoutobjsize"
#outputdir = currentdir+"/../data/hitimp"
#if not os.path.exists(outputdir):
#   os.makedirs(outputdir)

dropcolumn=["Belady", "QDLP", "FIFO-Merge"]
#accp4 ARC Cacheus Clock FIFO FIFO-Merge GDSF Hyperbolic LHD LIRS LeCaR QDLP S3FIFO S4LRU TwoQ WTinyLFU
out_column = ["accp4", "ARC", "Cacheus", "Clock", "FIFO", "FIFO-Merge", "GDSF", "Hyperbolic", "LHD", "LIRS", "LeCaR", "QDLP", "S3FIFO", "S4LRU", "WTinyLFU", "TwoQ", "accp4c", "accp4p"]
out_column = ["FlexCache", "S3-FIFO", "ARC", "CAR", "Cacheus", "LeCaR", "LIRS", "WTinyLFU", "GDSF", "Hyperbolic", "LHD", "S4LRU", "TwoQ", "GLCache", "Clock", "FIFO", "FIFO-Merge"]
out_column = ["FlexCache", "S3-FIFO", "ARC", "Cacheus", "LeCaR", "LIRS", "WTinyLFU", "GDSF"]
out_column = ["FlexCache", "S3-FIFO", "ARC", "CAR", "Cacheus", "LeCaR",  "LIRS", "WTinyLFU", "LHD"]
target_column = ["S3-FIFO", "ARC", "Cacheus", "LIRS", "WTinyLFU"]
target_column = ["S3-FIFO"]
out_row = ["systor", "metaCDN", "twitter", "fiu", "alibabaBlock", "msr", "tencentPhoto", "tencentBlock", "cloudphysics", "metaKV", "wikimedia"]
out_row = ["twitter", "metaKV", "metaCDN", "tencentPhoto", "wikimedia", "tencentBlock", "systor", "fiu", "msr", "alibabaBlock", "cloudphysics"]
out_row_rename = ["Twitter", "MetaKV", "MetaCDN", "TencentPhoto", "Wikimedia", "Tencent", "Systor", "fiu", "MSR", "Alibaba", "CloudPhysics"]
order_bench = ["MetaKV", "Twitter", "Tencent", "TencentPhoto", "Wikimedia","fiu", "CloudPhysics", "MSR"]

scope_column = ["FlexCache", "S3-FIFO", "ARC", "Cacheus", "LeCaR", "LIRS", "WTinyLFU", "GDSF", "Hyperbolic", "LHD", "TwoQ", "LRU"]

def readfile(filepath):
    #print("reading "+filepath)
    df = pd.read_csv(filepath,header=0,index_col=0)
    df.columns = df.columns.str.replace("flex-0.10-0.05-1.00", "FlexCache")
    df.columns = df.columns.str.replace("S3FIFO", "S3-FIFO")
    for col in dropcolumn:
        if col in df.columns:
            df.drop(col, axis=1, inplace=True)
    #if any row >= 1.0, drop it
    df = df[(df < 1.0).all(1)]
    return df

def findOutperformance(inputdir):
    for file in os.listdir(benchdir):
        name = os.path.splitext(file)[0]
        cachesize = float(name.split("-")[-1])
        df = readfile(benchdir+"/"+file)
        second_min_col = df.apply(lambda row: row.nsmallest(3).index, axis=1)
        mask = second_min_col.apply(lambda cols: "FlexCache" in cols)
        #df = df[mask]
        df = df[df["FlexCache"]<0.40]
        outperf = pd.DataFrame()
        for col in target_column:
            outperf[col] = df[col] - df["FlexCache"]
        #min_col = df.idxmin(axis=1)

        #找出每列前10大的提升，并对应输出df中的行
        for col in target_column:
            top10 = outperf[col].nlargest(10)
            top10 = top10[top10 > 0.05]
            topdf = df.loc[top10.index]
            #按照提升排序输出
            topdf = topdf.reindex(top10.index)
            
            if len(topdf) == 0:
                continue
            print(col)
            print(topdf)

def rankalg(inputdir):
    for file in os.listdir(inputdir):
        name = os.path.splitext(file)[0]
        cachesize = float(name.split("-")[-1])
        df = readfile(inputdir+"/"+file)
        if len(df) < 50:
            #pass
            continue
        dfhitrate = pd.DataFrame()
        for col in out_column:
            dfhitrate[col] = 1 - df[col]
            #dfhitrate[col] = (1 - df[col])/(1 - df["LRU"])
        dfmax = dfhitrate.max(axis=1)
        dfmax = dfmax * 0.95
        #find the rows where any column larger than 95% of max
        #counter the results for each column
        counter = {}
        for col in dfhitrate.columns:
            counter[col] = 0
        for index, row in dfhitrate.iterrows():
            for col in dfhitrate.columns:
                if row[col] >= dfmax[index]:
                    counter[col] += 1
        print(name,cachesize,len(dfhitrate))
        print(counter)
        percentcounter = {}
        for col in counter:
            percentcounter[col] = counter[col]/sum(counter.values())
        print(percentcounter)
        second_max_col = dfhitrate.apply(lambda row: row.nlargest(1).index, axis=1)
        counter2 = {}
        for col in dfhitrate.columns:
            counter2[col] = 0
        for index in second_max_col:
            counter2[index[0]] += 1
            counter2[index[1]] += 1
        print(counter2)

def relrankalg(inputdir):
    outdf = {}
    for file in os.listdir(inputdir):
        name = os.path.splitext(file)[0]
        cachesize = float(name.split("-")[-1])
        df = readfile(inputdir+"/"+file)
        if len(df) < 50:
            pass
            #continue
        dfhitrate = pd.DataFrame()
        for col in out_column:
            dfhitrate[col] = (1 - df[col])/(1 - df["LRU"])
            #dfhitrate[col] = (1 - df[col])
        #print(dfhitrate)
        dfmax = dfhitrate.max(axis=1)
        #dfmax = dfmax - 0.013
        dfmax = dfmax*0.995
        #find the rows where any column larger than 95% of max
        #counter the results for each column
        counter = {}
        for col in dfhitrate.columns:
            counter[col] = 0
        for index, row in dfhitrate.iterrows():
            for col in dfhitrate.columns:
                if row[col] >= dfmax[index]:
                    counter[col] += 1
        #print(name,cachesize,len(dfhitrate))
        #print(counter)
        percentcounter = {}
        for col in counter:
            percentcounter[col] = counter[col]/sum(counter.values()) * 100
        #print(percentcounter)
        second_max_col = dfhitrate.apply(lambda row: row.nlargest(2).index, axis=1)
        counter2 = {}
        for col in dfhitrate.columns:
            counter2[col] = 0
        for index in second_max_col:
            counter2[index[0]] += 2
            #counter2[index[1]] += 1
            #counter2[index[2]] += 1
        #print(counter2)
        percentcounter2 = {}
        for col in counter:
            percentcounter2[col] = counter2[col]/sum(counter2.values()) * 100
            
        outperform = {}
        outperformpercent = {}
        for col in dfhitrate.columns:
            outperform[col] = len(dfhitrate[dfhitrate[col] < dfhitrate["FlexCache"]])
            outperformpercent[col] = outperform[col]/len(dfhitrate) * 100
        
        averagehit = dfhitrate.prod(axis=0)**(1/len(dfhitrate))
        #averagehit -= min(averagehit)
        #averagehit /= sum(averagehit)
        #averagehit *= 10
        #normalize averagehit
        #averagehit = (averagehit - averagehit.min()) / (averagehit.max() - averagehit.min())
        outdf[cachesize] = pd.Series(averagehit)
        #sort outdf's rows according to float(index)
    return outdf

def plotsns(data):
    
    fig, axes = plt.subplots(1, len(data.keys()), figsize=(26, 5), sharey=True)
    for ax, (bench, df) in zip(axes, data.items()):
        plot_data = df.copy()
        plot_data -= 1
        plot_data *= 10
        sns.heatmap(data=plot_data, ax=ax, annot=False, fmt=".2f", cmap="Greens", cbar=False, norm=colors.LogNorm())
        data = df.copy()
        data -= 1
        data *= 100
        for i in range(data.shape[0]):
            for j in range(data.shape[1]):
                text = ax.text(j+0.5, i+0.5, f"{data.iat[i, j]:.1f}", ha="center", va="center", color="black", fontsize=8)
        ax.set_title(bench)
        if bench == list(data.keys())[0]:
            ax.set_ylabel("Policy")
        else:
            ax.set_ylabel("")
    plt.tight_layout()
    #plt.show()
    plt.savefig(currentdir+"/relrank.png", dpi=300)

def plot_one_sns(data):
    fig, ax = plt.subplots(figsize=(8, 6))
    plot_data = data.copy()
    '''
    for col in plot_data.columns:
        base = min(plot_data[col])
        base = max(base,1)
        plot_data[col] -= base
    #plot_data[col] *= 10
    '''
    plot_data -= 1
    plot_data *= 10
    #print(plot_data)
    sns.heatmap(data=plot_data, ax=ax, annot=False, fmt=".2f", cmap="Greens", cbar=False, norm=colors.LogNorm())
    #add new text for each cell
    data -= 1
    data *= 100
    for i in range(data.shape[0]):
        for j in range(data.shape[1]):
            text = ax.text(j+0.5, i+0.5, f"{data.iat[i, j]:.1f}", ha="center", va="center", color="black", fontsize=8)
    
    #ax.set_title("Relative Outperformance Rank")
    ax.set_ylabel("Policy")
    #ax.set_xlabel("Performance Improvement over LRU in Workloads")
    plt.tight_layout()
    #plt.show()
    plt.savefig(currentdir+"/relrank_one.png", dpi=300)
    
data = {}
for bench in os.listdir(inputdir):
    benchdir = inputdir+"/"+bench
    if not os.path.isdir(benchdir):
        continue
    #findOutperformance(benchdir)
    ret = relrankalg(benchdir)
    if len(ret) != 0:
        data[bench] = ret
#making data grouped by cachesize and then bench
datadf = {}
for bench in data:
    if bench == "systor":
        continue
    for cachesize in data[bench]:
        if cachesize not in datadf:
            datadf[cachesize] = pd.DataFrame()
        datadf[cachesize][out_row_rename[out_row.index(bench)]] = data[bench][cachesize]
for cachesize in datadf:
    datadf[cachesize] = datadf[cachesize][order_bench]
plotsns(datadf)
plot_one_sns(datadf[0.03])
