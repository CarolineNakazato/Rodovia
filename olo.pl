teste(a,(1:15)).
teste(b,(2:25)).
teste(c,9).

add(A,B,X):- teste(A,(HA:MA)),
 teste(B,(HB:MB)),
 X is HA * 60 + HB * 60 + MB + MA.

print(A,B,C):- teste(A,(B:C)).

total(All,H,M):- H is All // 60,
    M is All mod 60.
