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

def updatePattern(d):
    if d.hotness >= @\ABB{H}.threshold@:
        if d.epoch > 1:
            d.pattern = FP
        else:
            d.pattern = FE
    else:
        if d.epoch > 1:
            d.pattern = IP
        else:
            d.pattern = IE