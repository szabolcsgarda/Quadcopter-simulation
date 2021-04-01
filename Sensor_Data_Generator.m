clear all;
fs = 100; %Sampling frequency [Hz]
T = 2.5; %Duration in sec
firstLoopNumSamples = fs*4;
secondLoopNumSamples = fs*2;
totalNumSamples = fs*T;
%traj = kinematicTrajectory('SampleRate',fs);

%% Simple Roll
accBody = zeros(totalNumSamples,3);
angVelBody = zeros(totalNumSamples,3);
angVelBody(1:25,1)= pi/6;
angVelBody(50:75,1)= -pi/6;
angVelBody(100:125,1)= pi/4;
angVelBody(150:200,1)= -pi/4;
angVelBody(225:250,1)= pi/4;
t = (0:(totalNumSamples-1))/fs;
velocityX = cumtrapz(transpose(t),accBody(:,1));
velocityY = cumtrapz(transpose(t),accBody(:,2));
velocityZ = cumtrapz(transpose(t),accBody(:,3));
% displacementX = cumtrapz(transpose(t),velocityX);
% displacementY = cumtrapz(transpose(t),velocityY);
% displacementZ = cumtrapz(transpose(t),velocityZ);
% rollReference = cumtrapz(transpose(t),angVelBody(:,1));
% pitchReference = cumtrapz(transpose(t),angVelBody(:,2));
% yawReference = cumtrapz(transpose(t),angVelBody(:,3));
cHeader = {'time' 'aX' 'aY' 'aZ' 'wX' 'wY' 'wZ'};
t_T = transpose(t)
fileOut = [cHeader(1,1:7); t_T accBody angVelBody ]
csvwrite('Sensor_Data_Readings/SimpleRoll.csv',fileOut)

%% Simple Pitch
accBody = zeros(totalNumSamples,3);
angVelBody = zeros(totalNumSamples,3);
angVelBody(1:25,2)= pi/6;
angVelBody(50:75,2)= -pi/6;
angVelBody(100:125,2)= pi/4;
angVelBody(150:200,2)= -pi/4;
angVelBody(225:250,2)= pi/4;
t = (0:(totalNumSamples-1))/fs;
velocityX = cumtrapz(transpose(t),accBody(:,1));
velocityY = cumtrapz(transpose(t),accBody(:,2));
velocityZ = cumtrapz(transpose(t),accBody(:,3));
% displacementX = cumtrapz(transpose(t),velocityX);
% displacementY = cumtrapz(transpose(t),velocityY);
% displacementZ = cumtrapz(transpose(t),velocityZ);
% rollReference = cumtrapz(transpose(t),angVelBody(:,1));
% pitchReference = cumtrapz(transpose(t),angVelBody(:,2));
% yawReference = cumtrapz(transpose(t),angVelBody(:,3));
cHeader = {'time' 'aX' 'aY' 'aZ' 'wX' 'wY' 'wZ'};
fileOut = [cHeader; transpose(t) accBody angVelBody ]
csvwrite('Sensor_Data_Readings/SimplePith.csv',fileOut)

%% Simple Yaw
accBody = zeros(totalNumSamples,3);
angVelBody = zeros(totalNumSamples,3);
angVelBody(1:50,3)= pi/6;
angVelBody(75:125,3)= -pi/6;
angVelBody(150:175,3)= pi/4;
angVelBody(200:250,3)= -pi/4;
t = (0:(totalNumSamples-1))/fs;
velocityX = cumtrapz(transpose(t),accBody(:,1));
velocityY = cumtrapz(transpose(t),accBody(:,2));
velocityZ = cumtrapz(transpose(t),accBody(:,3));
displacementX = cumtrapz(transpose(t),velocityX);
displacementY = cumtrapz(transpose(t),velocityY);
displacementZ = cumtrapz(transpose(t),velocityZ);
rollReference = cumtrapz(transpose(t),angVelBody(:,1));
pitchReference = cumtrapz(transpose(t),angVelBody(:,2));
yawReference = cumtrapz(transpose(t),angVelBody(:,3));
cHeader = {'time' 'aX' 'aY' 'aZ' 'wX' 'wY' 'wZ'};
fileOut = [cHeader; transpose(t) accBody angVelBody ]
csvwrite('Sensor_Data_Readings/SimpleYaw.csv',fileOut)

%% Complex 1
accBody = zeros(totalNumSamples,3);
angVelBody = zeros(totalNumSamples,3);
angVelBody(1:50,2)= pi/4;
angVelBody(75:125,2)= -pi/4;
angVelBody(150:175,2)= pi/6;
angVelBody(200:250,2)= -pi/6;
angVelBody(1:50,3)= pi/6;
angVelBody(75:125,3)= -pi/6;
angVelBody(150:175,3)= pi/4;
angVelBody(200:250,3)= -pi/4;
t = (0:(totalNumSamples-1))/fs;
velocityX = cumtrapz(transpose(t),accBody(:,1));
velocityY = cumtrapz(transpose(t),accBody(:,2));
velocityZ = cumtrapz(transpose(t),accBody(:,3));
displacementX = cumtrapz(transpose(t),velocityX);
displacementY = cumtrapz(transpose(t),velocityY);
displacementZ = cumtrapz(transpose(t),velocityZ);
rollReference = cumtrapz(transpose(t),angVelBody(:,1));
pitchReference = cumtrapz(transpose(t),angVelBody(:,2));
yawReference = cumtrapz(transpose(t),angVelBody(:,3));
cHeader = {'time' 'aX' 'aY' 'aZ' 'wX' 'wY' 'wZ'};
fileOut = [cHeader; transpose(t) accBody angVelBody ]
csvwrite('Sensor_Data_Readings/Complex1.csv',fileOut)


%% Auxiliary Print
figure(1)
t = (0:(totalNumSamples-1))/fs;
subplot(3,1,1)
plot(t,transpose(rollReference), t,transpose(pitchReference), t,transpose(yawReference) )
hold on
plot(t,accBody(:,1))
hold off
legend('X-axis','Y-axis','Z-axis')
ylabel('Acceleration (m/s^2)')
title('Accelerometer Readings')