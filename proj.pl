%fatos
%acesso(campinas,"Sao Paulo",bandeirantes,100,(1:00)).
%acesso(campinas,"Sao Paulo",anhaguera,90,(0:50)).
%acesso(sorocaba,campinas,"Santos Dumont",110,(1:10)).
acesso(a, b, ab, 5, (0:21)).
acesso(a, b, ab2, 10, (0:15)).
acesso(b, c, bc, 8, (0:19)).
acesso(b, d, bd, 14, (0:13)).
acesso(d, e, de, 13, (0:23)).
acesso(d, e, de2, 609, (2:46)).
acesso(a, f, af, 8, (0:24)).
acesso(a, f, af2, 6, (0:36)).
acesso(a, g, ag, 100, (2:15)).
acesso(a, g, ag2, 90, (2:58)).
acesso(g, h, gh, 50, (0:49)).

%regras
rotaDireta(CidadeA,CidadeB,Rodovia):-acesso(CidadeA,CidadeB,Rodovia,_,_).
rotaDireta(CidadeA,CidadeB,Rodovia):-acesso(CidadeB,CidadeA,Rodovia,_,_).

pertence(X,[X|_]) :- !.
pertence(X,[_|L]) :- pertence(X,L).

add(X,[],[X]).
add(X,[Y|L1],[Y|L2]):-
    add(X,L1,L2).


caminho(CidadeA,CidadeB,Rodovias):-rotaDireta(CidadeA,CidadeB,Rodovia),
    add(Rodovia,[],Rodovias).
caminho(CidadeA,CidadeB,Rodovias):-acesso(CidadeC,CidadeB,Rodovia,_,_),
    caminho(CidadeC,CidadeC,Lista),
    add(Rodovia,Lista,Rodovias).
caminho(CidadeA,CidadeB,Rodovias):-acesso(CidadeC,CidadeA,Rodovia,_,_),
    caminho(CidadeB,CidadeC,Lista),
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
