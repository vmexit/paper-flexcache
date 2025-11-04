Input: The requested data d
d metadata: hotness, suspected, patternH, patternE
@\sys structure: \ABB{F},\ABB{M},\ABB{S},\ABB{G},\ABB{K},\ABB{H}@
patternH: FREQUENT, INFREQUENT; patternE: PERSISTENT, EPHEMERAL

def access(d):
    if d in @\ABB{M}@ or @\ABB{S}@:
        incHotness(d)
        d.suspected = False
    else if d in @\ABB{F}@:
        incHotness(d)
    else:
        insert(d)

def insert(d):
    while @\sys@ is full:
        evict()
    if d in @\ABB{G}@:#no PERSISTENT data in G
        incHotness(@\ABB{G}@.d)
        updatePattern(@\ABB{G}@.d)
        if @\ABB{G}@.d.patternH == FREQUENT:
            d.hotness = @\ABB{G}@.d.hotness
            insert d to head of @\ABB{M}@
            remove @\ABB{G}@.d from @\ABB{G}@
        else: #suspect and duplicate metadata
            d.suspected = True 
            insert d to head of @\ABB{S}@
            @\ABB{H}.distribution[0]++@ 
    else: #insert new data
        insert d to @\ABB{F}@
        @\ABB{H}.distribution[0]++@ 

def evict():
    evicted = False
    while not evicted and @\ABB{F}@ exceeds limitF:#adjustF
        x @$\leftarrow$@ tail of @\ABB{F}@ #remove x from @\ABB{F}@
        updatePattern(x)
        if x.patternH == FREQUENT:
            @\ABB{H}.distribution[x.hotness]--@ 
            x.hotness = 0
            @\ABB{H}.distribution[0]++@
            insert x to head of @\ABB{M}@
        else:
            insert x to head of @\ABB{G}@ 
            if x.patternE == PERSISTENT:
                d = copymedata(x), d.hotness = 0
                d.suspected = True #suspect and duplicate metadata
                @\ABB{H}.distribution[0]++@
                insert d to head of @\ABB{S}@
            else:
                evicted = True
    while not evicted:
        evicted = evictMS()
    while @\ABB{G}@ exceeds limitG: #adjustG
        x @$\leftarrow$@ tail of @\ABB{G}@ #remove x from @\ABB{G}@
        @\ABB{H}.distribution[x.hotness]--@ 
        recordEviction(x)

def evictMS():
    while @\ABB{M}@ exceeds limitM: #adjustM
        x @$\leftarrow$@ tail of @\ABB{M}@ #remove x from @\ABB{M}@
        insert x to head of @\ABB{S}@
    while @\ABB{S}@ exceeds limitS: #adjustS
        x @$\leftarrow$@ tail of @\ABB{S}@ #remove x from @\ABB{S}@
        if x.suspected == True:
            @\ABB{H}.distribution[x.hotness]--@
            return True
        else:
            recordEviction(x)
            if x.hotness > 0:
                decHotness(x)
                updatePattern(x)
                insert x to head of @\ABB{M}@
            else: #remove x from @\ABB{S}@
                @\ABB{H}.distribution[x.hotness]--@ 
                return True