%% Global properties
% Gravitational acceleration
g= -9.81;
% Ground level [m]
ground_level = 0;

%% Quadcopter properties
% Total weight
m = 2.2;
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
cl = 0.2; % F = w^2*cl
% drag coefficient
cd = 0.8; % M=w^2*cd
% Rotational inertia of propeller
Jprop = 0.2;

%% Sensor properties
gyro_update_rate = 0.01; 

%% Actuator properties
A = [0 0 epsilon -epsilon;
    epsilon -epsilon 0 0;
    cd/cl -cd/cl cd/cl -cd/cl;
    1 1 1 1];

P = [0 0 0 0;
    0 0 0 0;
	Jprop -Jprop -Jprop Jprop;
    0 0 0 0];

actuator_calculator = [
1 1 1 1;
0 -epsilon 0 epsilon;
epsilon 0 -epsilon 0;
-cd/cl cd/cl -cd/cl cd/cl
]
det(actuator_calculator)

