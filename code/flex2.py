def incHotness(d):
    orihot = d.hotness
    if orihot < HOTmax:
        d.hotness += 1
    updateH(orihot, d.hotness)

def decHotness(d):
    orihot = d.hotness
    if orihot > 0:
        d.hotness -= 1
    updateH(orihot, d.hotness)
    d.epoch += 1

def updateH(delhot, inchot):
    @\ABB{H}.distribution[delhot]--@
    @\ABB{H}.distribution[inchot]++@
    counter = 0
    for i from HOTmax downto 0:
        counter += @\ABB{H}.distribution[i]@
        if counter > CacheSize:
            @\ABB{H}.threshold@ = i
            break
        
def recordEviction(d):
    @\ABB{K}@.counter ++
    if @\ABB{K}@.counter >= EPOCHmax:
        @\ABB{K}@.counter = 0
        @\ABB{K}@.ageEpoch()
    @\ABB{K}@.incEpoch(d)

def epochUtility(d):
    return @\ABB{K}.findEpoch(d)@ + d.hotness

def updatePattern(d):
    guard = @\ABB{S}@.tail
    epochGuard = epochUtility(guard)
    if epochUtility(d) > epochGuard:
        d.patternE = PERSISTENT
    else:
        d.patternE = EPHEMERAL
    if d.hotness > @\ABB{H}.threshold@:
        d.patternH = FREQUENT
    else:
        d.patternH = INFREQUENT
