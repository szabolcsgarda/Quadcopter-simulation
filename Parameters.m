%% Global properties
% Gravitational acceleration
g= -9.81;
% Ground level [m]
ground_level = 0;

%% Quadcopter properties
% Total weight
m = 2.2;
gm = [0;0;g*m];
% Moments of inertia
Ixx = 0.2;
Iyy = 0.2;
Izz = 0.2;
% Initial position:
Pos_init = [0;0;0];
% Initial velocity:
Vel_init= [0;0;0];
%Motor-mass center distance [m]
epsilon = 0.22;
% lift coefficient
cl = 0.0000002; % F = w^2*cl
% drag coefficient
cd = 0.00000008; % M=w^2*cd
% Rotational inertia of propeller
Jprop = 0.2;
%Maximum value of Revolutions per min
maxRPM = 10000;
maxLiftForce = maxRPM^2 * cl;

%% Sensor properties
gyro_update_rate = 0.01; 

%% Actuator properties
A = [1 1 1 1;
0 -epsilon 0 epsilon;
epsilon 0 -epsilon 0;
-cd/cl cd/cl -cd/cl cd/cl];

P = [0 0 0 0;
    0 0 0 0;
    0 0 0 0
    Jprop -Jprop -Jprop Jprop];


% THIS MUST BE USED BECAUSE this form works only with the LU SOLVER
actuator_calculator = [
1 1 1 1;
0 -epsilon 0 epsilon;
epsilon 0 -epsilon 0;
-cd/cl cd/cl -cd/cl cd/cl]

