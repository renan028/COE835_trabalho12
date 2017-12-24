clear;
clc;
close all;
global a1 a2 w1 w2 lambda_f;

PRINT = true;
% PRINT = false;

%% 1nd order system

%Simulation time
tfinal = 30;

%Reference
w1 = [0.63493 4.5669];
w2 = [0.1 1.1];
a1 = [1 1];
a2 = [1 1];

%--------------- First set of parameters ----------------

%P
phi_1 = pi/4;
h_1 = 1;
Np_1 = [1 0;0 1];
Dp_1 = [1 0 0];
kp_1 = [cos(phi_1) sin(phi_1);-h_1*sin(phi_1) h_1*cos(phi_1)];

%Pm
lambda_1 = 1;
Nm_1 = [lambda_1^2 0;0 lambda_1^2];
Dm_1 = [1 2*lambda_1 lambda_1^2];

%L
lambda_f = 1;
L = [1 lambda_f];

%Initial conditions
y0_1  = 0;

%Adaptation gain
gamma_1 = 10;

%--------------- Second set of parameters ----------------

%P
phi_2 = pi/3;
h_2 = 2;
Np_2 = [1 0;0 1];
Dp_2 = [1 0 0];
kp_2 = [cos(phi_2) sin(phi_2);-h_1*sin(phi_2) h_1*cos(phi_2)];

%Pm
lambda_2 = 2;
Nm_2 = [lambda_2^2 0;0 lambda_2^2];
Dm_2 = [1 2*lambda_2 lambda_2^2];

%Initial conditions
y0_2  = 10;

%Adaptation gain
gamma_2 = 50;

run sim_mrac.m;
