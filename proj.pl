%fatos
%acesso(campinas,"Sao Paulo",bandeirantes,100,(1:00)).
%acesso(campinas,"Sao Paulo",anhaguera,90,(0:50)).
%acesso(sorocaba,campinas,"Santos Dumont",110,(1:10)).
acesso(a, b, x1, 100, (1:10)).
acesso(a, b, x2, 110, (1:00)).
acesso(b, c, x3, 100, (2:10)).
acesso(c,d, x4, 100, (00:30)).
acesso(a, d, x5, 300, (3:30)).
acesso(a, e, x6, 100, (1:10)).
acesso(e, c, x7, 250, (2:40)).
%regras
rotaDireta(CidadeA,CidadeB,Rodovia):-acesso(CidadeA,CidadeB,Rodovia,_,_).

pertence(X,[X|_]) :- !.
pertence(X,[_|L]) :- pertence(X,L).

add(X,[],[X]).
add(X,[Y|L1],[Y|L2]):-
    add(X,L1,L2).


caminho(CidadeA,CidadeB,Rodovias):-rotaDireta(CidadeA,CidadeB,Rodovia),
    add(Rodovia,[],Rodovias).
caminho(CidadeA,CidadeB,Rodovias):-acesso(CidadeC,CidadeB,Rodovia,_,_),
    caminho(CidadeA,CidadeC,Lista),
    add(Rodovia,Lista,Rodovias).

menorLista(X,[X]).
menorLista(N,[X,Y|Cauda]):-
    (X > Y, menorLista(N,[Y|Cauda]));
    (X =< Y, menorLista(N,[X|Cauda])).

rotaDiretaKm(CidadeA,CidadeB,Km):-acesso(CidadeA,CidadeB,_,Km,_).
rotaDiretaKM(CidadeA,CidadeB,Km):-acesso(CidadeB,CidadeA,_,Km,_).

caminhoKm(CidadeA,CidadeB,Kms):-rotaDiretaKm(CidadeA,CidadeB,Kms).

caminhoKm(CidadeA,CidadeB,Kms):-acesso(CidadeC,CidadeB,_,Km,_),
    caminhoKm(CidadeA,CidadeC,Lista),
    Kms is Km+Lista.

lista(A,B,ListaCaminhos):-
    findall(Km,caminhoKm(A,B,Km),ListaCaminhos).

menorCaminho(CidadeA,CidadeB,CaminhoKm):-lista(CidadeA,CidadeB,Lista),
    menorLista(CaminhoKm,Lista).
