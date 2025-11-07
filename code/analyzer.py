def access(d): #access data d in analyzer @\ABB{A}@
    if d in hotnessData:
        hotnessMap[hotnessData[d].hotness] -= 1
        hotnessData.d.hotness += 1
        hotnessMap[hotnessData.d.hotness] += 1
    else:
        hotnessData.insert(d)
        hotnessMap[d.hotness] += 1
    if hotnessData.size() > EPOCHsize:
        x @$\leftarrow$@ tail of hotnessData
        insert x to head of lastHotnessData
        epochRecord(x)
    if lastHotnessData.size() > EPOCHsize:
        y @$\leftarrow$@ tail of lastHotnessData
        hotnessMap[y.hotness]--
    adjustThreshold()
    
def epochRecord(d):
    insertCounter += 1
    if insertCounter >= EPOCHsize:
        insertCounter = 0
        epoch += 1
        ageEpoch()
    epochMap[sumEpoch(d)]-- #sum the epoch value of data d
    #hotness has a max contribution to epoch
    epochData[d].insert(capped(d.hotness), epoch)
    epochMap[sumEpoch(d)]++
    
def ageEpoch():
    evictEpoch = epoch - observeEpoch
    for d in epochData.iter():
        if epochData[d].earliestEpoch() <= evictEpoch:
            epochMap[sumEpoch(d)]--
            epochData[d].deleteEarliestEpoch()
            epochMap[sumEpoch(d)]++
    
def adjustThreshold():
    counter = 0
    for i in hotnessMap.iter(): #from max hotness to min
        counter += hotnessMap[i]
        if counter > CacheSize:
            hotnessThreshold = i
            break
    counter = 0
    for i in epochMap.iter(): #from max epoch to min
        counter += epochMap[i]
        if counter > CacheSize:
            epochThreshold = i
            break
        
def updatePattern(d):
    epochUtility = sumEpoch(d) #epoch utility of data d
    epochUtility += d.hotness #add an utility for the latest epoch
    if epochUtility > epochThreshold:
        d.patternE = PERSISTENT
    else:
        d.patternE = EPHEMERAL
    if d.hotness > hotnessThreshold:
        d.patternH = FREQUENT
    else:
        d.patternH = INFREQUENT