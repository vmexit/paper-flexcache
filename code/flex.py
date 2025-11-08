Input: The requested data d
d metadata: hotness, patternH, patternE, positionInG
@\sys structure: \ABB{F}, \ABB{M}, \ABB{S}, \ABB{G}, \ABB{A}@
patternH: FREQUENT, INFREQUENT; patternE: PERSISTENT, EPHEMERAL

def access(d):
    @\ABB{A}@.access(d)
    if d in @\ABB{M}@ or @\ABB{S}@ or @\ABB{F}@:#increase hotness of d with a max cap
        d.hotness = min(d.hotness+1, MAX_HOTNESS) 
    else:
        insert(d)

def insert(d):
    while @\sys@ is full:
        evict()
    if d in @\ABB{G}@:
        @\ABB{G}@.d.hotness = min(@\ABB{G}@.d.hotness+1, MAX_HOTNESS) 
        @\ABB{A}@.updatePattern(@\ABB{G}@.d)
        if @\ABB{G}@.d.patternH == FREQUENT or @\ABB{G}@.d.patternE == PERSISTENT:
            insert d to head of @\ABB{M}@
        else: 
            insert d to head of @\ABB{S}@
            record d.positionInG
        remove @\ABB{G}@.d from @\ABB{G}@
    else: #insert new data
        d.hotness = 0
        insert d to @\ABB{F}@

def evict():
    evicted = False
    while not evicted and @\ABB{F}@ exceeds limitF:#adjustF
        x @$\leftarrow$@ tail of @\ABB{F}@ #remove x from @\ABB{F}@
        @\ABB{A}@.updatePattern(x)
        if x.patternH == FREQUENT or x.patternE == PERSISTENT:
            x.hotness = 0
            insert x to head of @\ABB{M}@
        else:
            insert x to head of @\ABB{G}@ 
            evicted = True
    while not evicted:
        evicted = evictMS()
    while @\ABB{G}@ exceeds limitG: #adjustG
        remove tail of @\ABB{G}@

def evictMS():
    while @\ABB{M}@ exceeds limitM: #adjustM
        x @$\leftarrow$@ tail of @\ABB{M}@ #remove x from @\ABB{M}@
        insert x to head of @\ABB{S}@
    while @\ABB{S}@ exceeds limitS: #adjustS
        x @$\leftarrow$@ tail of @\ABB{S}@ #remove x from @\ABB{S}@
        x.hotness -= 1 #decrease hotness of x for a new epoch
        @\ABB{A}@.updatePattern(x)
        if x.patternH == FREQUENT or x.patternE == PERSISTENT:
            insert x to head of @\ABB{M}@, x.positionInG = NULL
        else: #remove x from @\ABB{S}@
            if x.positionInG:
                insert x to original position in @\ABB{G}@
            return True