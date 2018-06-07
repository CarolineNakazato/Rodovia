%fatos
acesso(campinas,"Sao Paulo",bandeirantes,100,(1:00)).
acesso(campinas,"Sao Paulo",anhaguera,90,(0:50)).
acesso(sorocaba,campinas,"Santos Dumont",110,(1:10)).

%regras
rotaDireta(CidadeA,CidadeB,Rodovia):-acesso(CidadeA,CidadeB,Rodovia,_,_).
rotaDireta(CidadeA,CidadeB,Rodovia):-acesso(CidadeB,CidadeA,Rodovia,_,_).

pertence(X,[X|_]) :- !.
pertence(X,[_|L]) :- pertence(X,L).

add(X,L,L):-pertence(X,L),!.
add(X,L,[X|L]).

caminho(CidadeA,CidadeB,Rodovias):-rotaDireta(CidadeA,CidadeB,Rodovia),
    add(Rodovia,[],Rodovias).
caminho(CidadeA,CidadeB,Rodovias):-acesso(CidadeA,CidadeC,Rodovia,_,_),
    caminho(CidadeC,CidadeB,Lista),
    add(Rodovia,Lista,Rodovias).
caminho(CidadeA,CidadeB,Rodovias):-acesso(CidadeB,CidadeC,Rodovia,_,_),
    caminho(CidadeC,CidadeA,Lista),
    add(Rodovia,Lista,Rodovias).

menor(X,Y,X):-X=<Y,!.
menor(_,Y,Y).

tamanho([],0).
tamanho([_|Cauda],N):-tamanho(Cauda,N1),
	N is 1+N1.

menorCaminho(CidadeA,CidadeB,CaminhoKm).

