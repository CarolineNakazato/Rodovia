% Acesso(CidadeOrigem, CidadeDestino, NomeRodovia, Quilometros, (tempo))
% acesso(A, B, R, km, (tempo))
acesso(a, b, ab, 5, (0:21)).
acesso(a, b, ab2, 10, (0:15)).
acesso(a, b, x1, 100, (1:10)).
acesso(a, b, x2, 110, (1:00)).
acesso(b, c, x3, 100, (2:10)).
acesso(c ,d, x4, 100, (00:30)).
acesso(a, d, x5, 300, (3:30)).
acesso(a, e, x6, 100, (1:10)).
acesso(e, c, x7, 250, (2:40)).

rotaDireta(CidadeA,CidadeB,Rodovia):-acesso(CidadeA,CidadeB,Rodovia,_,_).

pertence(X,[X|_]) :- !.
pertence(X,[_|L]) :- pertence(X,L).

add(X,L,L):-pertence(X,L),!.
add(X,L,[X|L]).

caminho(CidadeA,CidadeB,Rodovias):-rotaDireta(CidadeA,CidadeB,Rodovia),
    add(Rodovia,[],Rodovias).
caminho(CidadeA,CidadeB,Rodovias):-acesso(CidadeC,CidadeB,Rodovia,_,_),
    caminho(CidadeA,CidadeC,Lista),
    add(Rodovia,Lista,Rodovias).

addTempo(Total,Rodovias):- Total =:= 0,
    Total is 0,
    addTempo(Total,Rodovias).
addTempo(Total,Rodovias):-Rodovias[X|Resto],
    acesso(_,_,X_,(H:M)),
    Total is Total + (H * 60) + M,
    addTempo(Total,Resto).

horaMinuto(Total, Hora, Minuto):-Hora is Total // 60,
    Minuto is Total mod 60.

menorTempo(CidadeA,CidadeB,Tempo):-caminho(CidadeA,CidadeB,Rodovias),
    addTempo(Total,Rodovias),
    horaMinuto(Total, H, M),
    Tempo((H:M)).



