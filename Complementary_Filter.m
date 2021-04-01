%The script creates am instance of the Matlab's built in IMU, read in
%predefined acceleration and angular velocity definitions from file
%and fed this to the sensor models. Finally it runs the derived comple-
%mentary filter in order to estimate the attitude/position
clear all;
%Read CSV file
fid = fopen('Sensor_Data_Readings/SimpleRoll.csv');
T = textscan(fid,'%f%f%f%f%f','Headerlines',0 );
t = T(:,1)
t= transpose(t)
accBody = transpose(T(:,2:4))
angVelBody = transpose(T(:,5:7))

%reference
velocityX = cumtrapz(transpose(t),accBody(:,1));
velocityY = cumtrapz(transpose(t),accBody(:,2));
velocityZ = cumtrapz(transpose(t),accBody(:,3)); 
displacementX = cumtrapz(transpose(t),velocityX);
displacementY = cumtrapz(transpose(t),velocityY);
displacementZ = cumtrapz(transpose(t),velocityZ);
rollReference = cumtrapz(transpose(t),angVelBody(:,1));
pitchReference = cumtrapz(transpose(t),angVelBody(:,2));
yawReference = cumtrapz(transpose(t),angVelBody(:,3));

traj = kinematicTrajectory('SampleRate',fs);

accBody = zeros(totalNumSamples,3);
angVelBody = zeros(totalNumSamples,3);
angVelBody(1:600,3) = (2*pi)/2;
%angVelBody(1:5,1) = (2*pi)/2;

[~,orientationNED,~,accNED,angVelNED] = traj(accBody,angVelBody);


IMU = imuSensor('accel-gyro-mag','SampleRate',fs);

IMU.Accelerometer = accelparams( ...
    'MeasurementRange',19.62, ...            % m/s^2
    'Resolution',0.0023936, ...              % m/s^2 / LSB
    'TemperatureScaleFactor',0.008, ...      % % / degree C
    'ConstantBias',0.1962, ...               % m/s^2
    'TemperatureBias',0.0014715, ...         % m/s^2 / degree C
    'NoiseDensity',0.0012361);               % m/s^2 / Hz^(1/2)

IMU.Gyroscope = gyroparams( ...
    'MeasurementRange',4.3633, ...
    'Resolution',0.00013323, ...
    'AxesMisalignment',2, ...
    'NoiseDensity',8.7266e-05, ...
    'TemperatureBias',0.34907, ...
    'TemperatureScaleFactor',0.02, ...
    'AccelerationBias',0.00017809, ...
    'ConstantBias',[0.3491,0.5,0]);

IMU.Magnetometer = magparams( ...
    'MeasurementRange',1200, ...             % uT
    'Resolution',0.1, ...                    % uT / LSB
    'TemperatureScaleFactor',0.1, ...        % % / degree C
    'ConstantBias',1, ...                    % uT
    'TemperatureBias',[0.8 0.8 2.4], ...     % uT / degree C
    'NoiseDensity',[0.6 0.6 0.9]/sqrt(100)); % uT / Hz^(1/2)

[accelReadings,gyroReadings, magReadings] = IMU(accNED,angVelNED,orientationNED);

figure(1)
t = (0:(totalNumSamples-1))/fs;
subplot(3,1,1)
plot(t,accelReadings(:,1))
hold on
plot(t,accBody(:,1))
hold off
legend('X-axis','Y-axis','Z-axis')
ylabel('Acceleration (m/s^2)')
title('Accelerometer Readings')

subplot(3,1,2)
plot(t,gyroReadings)
legend('X-axis','Y-axis','Z-axis')
ylabel('Angular velocity [rad/s]')
xlabel('Time (s)')
title('Gyro Readings')

subplot(3,1,3)
plot(t,magReadings)
legend('X-axis','Y-axis','Z-axis')
ylabel('Magnetic Field (\muT)')
xlabel('Time (s)')
title('Magnetometer Readings')


%Roll and Pitch from accelerometer data
roll_acc_est = atan2(accelReadings(:,1),accelReadings(:,3));
pitch_acc_est = atan2(-accelReadings(:,1),sqrt(accelReadings(:,2).^2+accelReadings(:,3).^2))
figure(2)
plot(t,roll_acc_est,t,pitch_acc_est)
legend('Estimated Roll','Estimated Pitch')
ylabel('Angle[Rad]')
xlabel('Time [s]')
title('Estimated Roll and Pitch angles from accelerometer data')

%Yaw from magnetometer data using real roll and pitch
Xh = cos(pitch_acc_est).*magReadings(:,1) + sin(pitch_acc_est).*sin(roll_acc_est).*magReadings(:,2)+sin(pitch_acc_est).*cos(roll_acc_est).*magReadings(:,3);
Yh = -cos(roll_acc_est).*magReadings(:,2)+sin(roll_acc_est).*magReadings(:,3);

yaw_mag_est = -1 * atan2(Yh,Xh);
figure(3)
plot(t,yaw_mag_est)
legend('Estimated Yaw')
ylabel('Angle[Rad]')
xlabel('Time [s]')
title('Estimated yaw')
hold on

