% Tanque 0
:- module(tanque0, [obter_controles/2]).

%% Explicação:
% Sensores:
% X: posição horizontal do tanque
% Y: posiçao vertical do tanque
% ANGLE: angulo de inclinacao do robo: 0 para virado para frente até PI*2 (~6.28)
% Sensores: esquerda (S1,S2), centro (S3), direita (S4,S5), ré (S6)
%   S1,S2,S3,S4,S5,S6: valores de 0 à 1, onde 0 indica sem obstáculo e 1 indica tocando o tanque
% SCORE: inteiro com a "vida" do tanque. Em zero, ele perdeu
% Controles:
% [FORWARD, REVERSE, LEFT, RIGHT, BOOM]
% FORWARD: 1 para ir pra frente e 0 para não ir
% REVERSE: 1 para ir pra tras e 0 para não ir
% LEFT: 1 para ir pra esquerda e 0 para não ir
% RIGHT: 1 para ir pra direita e 0 para não ir
% BOOM: 1 para tentar disparar (BOOM), pois ele só pode disparar uma bala a cada segundo
% obter_controles([X,Y,ANGLE,S1,S2,S3,S4,S5,S6], [FORWARD, REVERSE, LEFT, RIGHT, BOOM]) :-
%     FORWARD is 1,
%     REVERSE is 0,
%     LEFT is 1,
%     RIGHT is 0,
%     BOOM is 1.

%%% Faça seu codigo a partir daqui, sendo necessario sempre ter o predicado:
%%%% obter_controles([X,Y,ANGLE,S1,S2,S3,S4,S5,S6,SCORE], [FORWARD, REVERSE, LEFT, RIGHT, BOOM]) :- ...

% [FORWARD, REVERSE, LEFT, RIGHT, BOOM]
obter_controles([X, Y, ANGLE, S1, S2, S3, S4, S5, S6, SCORE], [FORWARD, REVERSE, LEFT, RIGHT, BOOM]) :-
    % vai pra trás se houver presença em todos os lados
    (S1 > 0, S2 > 0, S4 > 0, S5 > 0 -> 
        REVERSE is 1, FORWARD is 0, LEFT is 0, RIGHT is 0
    ; % Caso contrário
        % Se não houver presença no centro, avança
        (S3 < 0.7 -> FORWARD is 1; FORWARD is 0),
        % Vai pro lado que tem mais presença detectada
        (S1 + S2 > S4 + S5 -> LEFT is 1, RIGHT is 0; LEFT is 0, RIGHT is 1),
        REVERSE is 0
    ),
    % Decidir se deve atirar com base no sensor frontal
    (S3 > 0.2 -> BOOM is 1; BOOM is 0).  % Atira se algo for detectado pelo sensor frontal
  

% Para evitar erros, o tanque para:
obter_controles(_, [0,0,0,0,0]).