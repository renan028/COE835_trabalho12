%======================================================================
%
%  COE-835  Controle adaptativo
%
%  Script para simular o exemplo
%
%  MRAC  : n  = 2     First order plant
%          n* = 2     Relative degree
%          np = 17    Adaptive parameters
%
%======================================================================
function dx=mrac(t,x)

global sysP sysM sysL gamma w1 w2 a1 a2;

xp        = x(1:4);
xm        = x(5:8);
uf        = x(9:10);
yf        = x(11:12);
omega_f   = x(13:20);
theta     = x(21:end);

y = sysP.C*xp;
ym = sysM.C*xm;
%--------------------------
r1 = 0;
r2 = 0;
for i=1:length(w1)
    r1 = r1 + a1(i)*sin(w1(i)*t);
    r2 = r2 + a2(i)*sin(w2(i)*t);
end

r = [r1 r2]';

omega = [uf' yf' y' r']';
zeta1 = (omega_f'*[eye(8) theta(10:end)])';
zeta2 = omega_f;

e  = y - ym;

%% ------ Adaptacao -------
dtheta = -gamma*[zeta1'*e(1), zeta2'*e(2)]';

%% ----- u ------
Omega2 = omega;
u2 = Omega2'*theta(10:end) + zeta2'*dtheta(10:end);

Omega1 = [omega' u2]';
u1 = Omega1'*theta(1:9) + zeta1'*dtheta(1:9);

u = [u1 u2]';

%% ------- Planta --------
dxp = sysP.A*xp + sysP.B*u;

%% ------- Modelo --------
dxm = sysM.A*xm + sysM.B*r;

%% ------ omega_1 --------
duf = sysL.A*uf + sysL.B*u;

%% ------ omega_2 --------
dyf = sysL.A*yf + sysL.B*y;

%% ------ omega_f --------
domega_f = sysL.A*omega_f + sysL.B*omega;

%--------------------------
dx = [dxp' dxm' duf' dyf' domega_f' dtheta']';    %Translation