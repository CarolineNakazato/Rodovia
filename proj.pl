%Caroline Nakazato Ra:17164260
%Fabio Irokawa Ra:17057720
%
%fatos
acesso(a, b, x1, 100, (1:10)).
acesso(a, b, x2, 110, (1:00)).
acesso(b, c, x3, 100, (2:10)).
acesso(c, d, x4, 100, (00:30)).
acesso(a, d, x5, 300, (3:30)).
acesso(a, e, x6, 100, (1:10)).
acesso(e, c, x7, 250, (2:40)).

%regras
%
%Mostra se existe apenas uma rodovia que liga duas cidades
rotaDireta(CidadeA,CidadeB,Rodovia):-acesso(CidadeA,CidadeB,Rodovia,_,_).

% adiciona um valor a lista
add(X,[],[X]).
add(X,[Y|L1],[Y|L2]):-add(X,L1,L2).

%Mostra caminhos possíveis de uma cidade a outra
caminho(CidadeA,CidadeB,Rodovias):-rotaDireta(CidadeA,CidadeB,Rodovia),
    add(Rodovia,[],Rodovias).

caminho(CidadeA,CidadeB,Rodovias):-acesso(CidadeC,CidadeB,Rodovia,_,_),
    caminho(CidadeA,CidadeC,Lista),
    add(Rodovia,Lista,Rodovias).

%--------------Menor Caminho--------------------
%
% Calcula o menor valor de uma lista
menorLista(X,[X]).
menorLista(Menor,[X,Y|Cauda]):-
    (X > Y, menorLista(Menor,[Y|Cauda]));
    (X =< Y, menorLista(Menor,[X|Cauda])).

% Mostra o Quilometro da Rodovia que liga duas cidades
rotaDiretaKm(CidadeA,CidadeB,Km):-acesso(CidadeA,CidadeB,_,Km,_).

% Mostra os Quilometros percorridos entre duas cidades
caminhoKm(CidadeA,CidadeB,Kms):-rotaDiretaKm(CidadeA,CidadeB,Kms).

caminhoKm(CidadeA,CidadeB,Kms):-acesso(CidadeC,CidadeB,_,Km,_),
    caminhoKm(CidadeA,CidadeC,Lista),
    Kms is Km+Lista.

% Coloca todos possíveis Km dos caminhos entre duas cidades em uma lista
lista(A,B,ListaCaminhos):-findall(Km,caminhoKm(A,B,Km),ListaCaminhos).

% Mostra o menor Km entre a Lista de caminhos possíeis.
menorCaminho(CidadeA,CidadeB,CaminhoKm):-lista(CidadeA,CidadeB,Lista),
    menorLista(CaminhoKm,Lista).

%------------------Menor Tempo---------------------
%
% Converte o tempo (H:M) em minutos
convTempoMin(Hora:Minuto,MinTotal) :- MinTotal is Hora*60+Minuto.

% Converte minutos em tempo (H:M)
convMinTempo(MinTotal,(Hora:Min)) :-
    Hora is MinTotal//60,
    Min is MinTotal-(Hora*60).

% Mostra os Minutos que demora entre duas cidades (diretamente ligada)
rotaDiretaTempo(CidadeA,CidadeB,Tempo):-acesso(CidadeA,CidadeB,_,_,(Hora:Min)),
    convTempoMin(Hora:Min,Tempo).

% Mostra os Mintutos percorrido entre duas cidades
caminhoTempo(CidadeA,CidadeB,Tempo):-rotaDiretaTempo(CidadeA,CidadeB,Tempo).

caminhoTempo(CidadeA,CidadeB,Tempo):-acesso(CidadeC,CidadeB,_,_,(HoraAtual:MinAtual)),
    caminhoTempo(CidadeA,CidadeC,TempoLista),
    convTempoMin(HoraAtual:MinAtual,MinTotal),
    Tempo is MinTotal+TempoLista.

% Coloca os Minutos dos caminhos possíveis entre duas cidades em uma lista
listaTempo(A,B,ListaTempo):-
    findall(Tempo,caminhoTempo(A,B,Tempo),ListaTempo).

% Mostra o menor Tempo entre a Lista de Tempos percorridos
menorTempo(CidadeA,CidadeB,Tempo):-listaTempo(CidadeA,CidadeB,Lista),
    menorLista(MinTotal,Lista),
    convMinTempo(MinTotal,Tempo).

%-----------------Tempo do Menor Caminho-------------------
%
% Mostra os Minutos e o Km percorrido entre duas cidades (diretamente ligada)
rotaDiretaKmTempo(CidadeA,CidadeB,Km,Tempo):-acesso(CidadeA,CidadeB,_,Km,(Hora:Min)),
   convTempoMin(Hora:Min,Tempo).

% Mostra os Mintutos e a soma de Km para ir de uma cidades a outra
caminhoKmTempo(CidadeA,CidadeB,Kms,Tempo):-rotaDiretaKmTempo(CidadeA,CidadeB,Kms,Tempo).

caminhoKmTempo(CidadeA,CidadeB,Kms,Tempo):-acesso(CidadeC,CidadeB,_,Km,(HoraAtual:MinAtual)),
    caminhoKmTempo(CidadeA,CidadeC,KmLista,TempoLista),
    Kms is Km+KmLista,
    convTempoMin(HoraAtual:MinAtual,MinTotal),
    Tempo is MinTotal+TempoLista.

% Mostra o Tempo do menor Caminho
tempoMenorCaminho(CidadeA, CidadeB,Tempo):-menorCaminho(CidadeA,CidadeB,Km),
    caminhoKmTempo(CidadeA,CidadeB,Km,MinTotal),
    convMinTempo(MinTotal,Tempo).




















