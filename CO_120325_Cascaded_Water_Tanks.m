% Group Assignment - Control of Water Level for Two Cascading Tanks
% Module Code: KD6031
% Module Title: Instrumentation and Control of Dynamical Systems
% Student Names: Amy Kell       - 19004417
%                Thomas Gardner - 23040363
%                Khaled Ibrahim - 22023622 
%                Constantin Ott - 24056675

%% Reset the System
clear all;
close all;

%% Generall Constants

g = 9.81;                               % Gravitational constant [m/s^2]
my = 1.002e-3;                          % Viscosity of water [mPa*s]
q_in = 3.4e-3;                          % Waterflow in Tank 1 [m^3/s]

%% Constants Tanks
d_tank1 = 0.75;                         % Diameter Tank 1 [m]
d_tank2 = 0.75;                         % Diameter Tank 2 [m]

r_tank1 = d_tank1/2;                    % Radius Tank 1 [m]
r_tank2 = d_tank2/2;                    % Radius Tank 2 [m]

A_tank1 = pi*r_tank1^2;                 % Cross-sectional area Tank 1 [m^2]
A_tank2 = pi*r_tank2^2;                 % Cross-sectional area Tank 2 [m^2]

%% Constants Pipes
d_pipe1 = 3.13e-2;                         % Diameter Pipe 1 [m]
d_pipe2 = 3.13e-2;                         % Diameter Pipe 2 [m]

r_pipe1 = d_pipe1/2;                    % Radius Tank 1 [m]
r_pipe2 = d_pipe2/2;                    % Radius Tank 2 [m]

L_pipe1 = 4e-2;                         % Length Pipe 1 [m]
L_pipe2 = 4e-2;                         % Length Pipe 2 [m]

A_pipe1 = pi*r_pipe1^2;                 % Cross-sectional area Pipe 1 [m^2]
A_pipe2 = pi*r_pipe2^2;                 % Cross-sectional area Pipe 2 [m^2]

R_pipe1 = 8*my*L_pipe1/(pi*r_pipe1^4);  % Resistance Laminar flow Pipe 1 [kg/(s*m^4)]
R_pipe2 = 8*my*L_pipe2/(pi*r_pipe2^4);  % Resistance Laminar flow Pipe 2 [kg/(s*m^4)]

%% Constants Transferfunction (polynomial form)

a0 = R_pipe2;

b0 = 1;
b1 = A_tank1*R_pipe1 + A_tank2*R_pipe2;
b2 = A_tank1*A_tank2*R_pipe1*R_pipe2;

%% Definition of System Transferfunction

G = tf(a0, [b2 b1 b0]);

Gc_1 = tf([301.476 1.024 3.88e-4], [1 0])

G_w1 = feedback(Gc_1*G,0.0076);

Gc_2 = tf([626.5 3.92/2.6 1.23e-3],[1 0]);

G_w2 = feedback(Gc_2*G, 0.0076);

stepinfo(q_in*G_w1)

stepinfo(q_in*G_w2)
%% Step Response
figure('Name', 'Step-Response','NumberTitle','off')
step(q_in*G);grid;











