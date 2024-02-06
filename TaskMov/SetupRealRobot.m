%%% SetupRealRobot.m
% Monta o modelo cinemático da robô apenas as juntas existentes

% TO-DO:
%  1 - Verificar se são realmente essas juntas (estrutura)
%  2 - Mudar nome do uLINK para aceitar dois modelos ao mesmo tempo (variável
% global)
%  3 - Checar dimensões para mais cabíveis ao projeto

global uLINK

ToDeg = 180/pi;
ToRad = pi/180;
UX = [1 0 0]';
UY = [0 1 0]';
UZ = [0 0 1]';

uLINK    = struct('name','BODY'    , 'sister', 0, 'child', 2, 'b',[0  0    0.7]','a',UZ,'q',0);

uLINK(2) = struct('name','RLEG_J1' , 'sister', 6, 'child', 3, 'b',[0 -0.1 0]'   ,'a',UX,'q',0);
uLINK(3) = struct('name','RLEG_J2' , 'sister', 0, 'child', 4, 'b',[0  0   0]'   ,'a',UY,'q',0);
uLINK(4) = struct('name','RLEG_J3' , 'sister', 0, 'child', 5, 'b',[0  0  -0.3]' ,'a',UY,'q',0);
uLINK(5) = struct('name','RLEG_J4' , 'sister', 0, 'child', 0, 'b',[0  0  -0.3]' ,'a',UX,'q',0);

uLINK(6) = struct('name','LLEG_J1' , 'sister', 0, 'child',7, 'b',[0  0.1 0]'   ,'a',UX,'q',0);
uLINK(7) = struct('name','LLEG_J2' , 'sister', 0, 'child',8, 'b',[0  0   0]'   ,'a',UY,'q',0);
uLINK(8) = struct('name','LLEG_J3' , 'sister', 0, 'child',9, 'b',[0  0  -0.3]' ,'a',UY,'q',0);
uLINK(9) = struct('name','LLEG_J4' , 'sister', 0, 'child',0, 'b',[0  0  -0.3]' ,'a',UX,'q',0);

[uLINK(1).vertex,uLINK(1).face]   = MakeBox([0.1 0.3 0.5]  ,[0.05  0.15 -0.05] );   % BODY
[uLINK(5).vertex,uLINK(5).face]   = MakeBox([0.2 0.1 0.02] ,[0.05  0.05 0.05]);     % Foot
[uLINK(9).vertex,uLINK(9).face]   = MakeBox([0.2 0.1 0.02] ,[0.05  0.05 0.05]);     % Foot

FindMother(1);   % Find mother link from sister and child data

%%% Substitute the ID to the link name variables. For example, BODY=1.
for n=1:length(uLINK)
    eval([uLINK(n).name,'=',num2str(n),';']);
end

uLINK(BODY).p = [0.0, 0.0, 0.65]';
uLINK(BODY).R = eye(3);
ForwardKinematics(1);