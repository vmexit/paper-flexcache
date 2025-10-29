Input: The requested data d
d metadata: hotness, epoch, suspected, pattern
@\sys structure: \ABB{F},\ABB{M},\ABB{S},\ABB{G},\ABB{K},\ABB{H}@
patterns: IE, FE, IP, FP

def access(d):
    if d in @\ABB{M}@ or @\ABB{S}@:
        incHotness(d)
        d.suspected = False
    else if d in @\ABB{F}@:
        incHotness(d)
        updatePattern(d)
    else:
        insert(d)

def insert(d):
    while @\sys@ is full:
        evict()
    if d in @\ABB{G}@:
        incHotness(@\ABB{G}@.d)
        updatePattern(@\ABB{G}@.d)
        if @\ABB{G}@.d.pattern == FE:
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
    while not evicted and @\ABB{F}@ exceeds limitF:
        x @$\leftarrow$@ tail of @\ABB{F}@ #adjustF
        if x.pattern == FE:
            @\ABB{H}.distribution[x.hotness]--@ 
            x.hotness = 0
            @\ABB{H}.distribution[0]++@
            insert x to head of @\ABB{M}@
        else:
            insert x to head of @\ABB{G}@ #remove x from @\ABB{F}@
            guard = @\ABB{S}@.tail 
            if @\ABB{K}@.epoch(x) > guard.hotness+guard.epoch:
                d = copymedata(x), d.hotness = 0
                d.pattern = IP, d.suspected = True #suspect x as IP
                @\ABB{H}.distribution[0]++@
                insert d to head of @\ABB{S}@
            else:
                evicted = True
    while not evicted:
        evicted = evictMS()
    while @\ABB{G}@ exceeds limitG: #remove tail of G
        x @$\leftarrow$@ tail of @\ABB{G}@
        @\ABB{H}.distribution[x.hotness]--@ 
        @\ABB{K}@.recordEviction(x)

def evictMS():
    while @\ABB{M}@ exceeds limitM: #adjustM
        x @$\leftarrow$@ tail of @\ABB{M}@ 
        insert x to head of @\ABB{S}@
    while @\ABB{S}@ exceeds limitS: #adjustS
        x @$\leftarrow$@ tail of @\ABB{S}@ 
        if x.suspected == True: #remove x from @\ABB{S}@
            @\ABB{H}.distribution[x.hotness]--@ 
            return True
        else:
            @\ABB{K}@.recordEviction(x)
            if x.hotness > 0:
                decHotness(x)
                updatePattern(x)
                insert x to head of @\ABB{M}@
            else: #remove x from @\ABB{S}@
                @\ABB{H}.distribution[x.hotness]--@ 
                return True