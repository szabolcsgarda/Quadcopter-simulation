%clear all;
fid = fopen('IMU_datasets/Complex.csv');
fout = textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter',',');
fclose(fid);

time = fout{1};
ref_roll = [time fout{2}];
ref_pitch = [time fout{3}];
ref_yaw = [time fout{4}];

acc_x = [time fout{5}];
acc_y = [time fout{6}];
acc_z = [time fout{7}];

gyro_x = [time fout{8}];
gyro_y = [time fout{9}];
gyro_z = [time fout{10}];

mag_x = [time fout{11}];
mag_y = [time fout{12}];
mag_z = [time fout{13}];


%figure
%plot(time, ref_roll(:,2),time, ref_pitch(:,2),time, ref_yaw(:,2))

%figure
%plot(time, acc_x(:,2), time, acc_y(:,2),time, acc_z(:,2))

%figure 
%plot(time, mag_x(:,2),time, mag_y(:,2),time, mag_z(:,2))

Ki = 10;
Kp = 4.46;
Kiyaw = 0.025;
Kpyaw = 0.14;
yawoffset = ref_yaw(1,2);
yawoffsetRad = (yawoffset/180)*pi;
 


% Plot integration
figure
t = tiledlayout(3,1); % Requires R2019b or later
ax1 = nexttile;
plot(ax1,out.roll_integrated.time, out.roll_integrated.signals.values,time,ref_roll(:,2))
xlim([0 15])
xlabel('time [s]')
ylabel('Roll angle [Degree]')
legend('Simple integration','Reference','FontSize',8)

ax2 = nexttile;
plot(ax2,out.pitch_integrated.time, out.pitch_integrated.signals.values,time, ref_pitch(:,2))
xlim([0 15])
xlabel('time [s]')
ylabel('Pitch angle [Degree]')
legend('Simple integration','Reference','FontSize',8)

ax3 = nexttile
plot(ax3,out.yaw_integrated.time, out.yaw_integrated.signals.values, time, ref_yaw(:,2))
xlim([0 15])
xlabel('time [s]')
ylabel('Yaw angle [Degree]')
legend('Simple integration','Reference','FontSize',8)
saveas(gcf,'simple_integration.pdf')



% Plot Estiamtion
figure
t = tiledlayout(3,1); % Requires R2019b or later
ax1 = nexttile;
plot(ax1,out.roll_estimated.time, out.roll_estimated.signals.values,time,ref_roll(:,2))
xlim([0 15])
xlabel('time [s]')
ylabel('Roll angle [Degree]')
legend('Estimated','Reference','FontSize',8)

ax2 = nexttile;
plot(ax2,out.pitch_estimated.time, out.pitch_estimated.signals.values,time, ref_pitch(:,2))
xlim([0 15])
xlabel('time [s]')
ylabel('Pitch angle [Degree]')
legend('Estimated','Reference','FontSize',8)

ax3 = nexttile
plot(ax3,out.yaw_estimated.time, out.yaw_estimated.signals.values, time, ref_yaw(:,2))
xlim([0 15])
xlabel('time [s]')
ylabel('Yaw angle [Degree]')
legend('Estimated','Reference','FontSize',8)
saveas(gcf,'complementary_estimation.pdf')

%Plot accelerometer-based roll and pitch estimations
figure
t = tiledlayout(2,1); % Requires R2019b or later
ax1 = nexttile;
plot(ax1,out.roll_accelerometer.time, out.roll_accelerometer.signals.values,time,ref_roll(:,2))
xlim([0 15])
xlabel('time [s]')
ylabel('Roll angle [Degree]')
legend('Estimated','Reference','FontSize',8)


ax2 = nexttile;
plot(ax2,out.pitch_accelerometer.time, out.pitch_accelerometer.signals.values,time, ref_pitch(:,2))
xlim([0 15])
xlabel('time [s]')
ylabel('Pitch angle [Degree]')
legend('Estimated','Reference','FontSize',8)

saveas(gcf,'acc_estimations.pdf')


% Plot Magnetometer-based Yaw estiamtion
figure
t = tiledlayout(1,1); % Requires R2019b or later
ax3 = nexttile
plot(ax3,out.yaw_magnetometer.time, out.yaw_magnetometer.signals.values, time, ref_yaw(:,2))
xlim([0 15])
xlabel('time [s]')
ylabel('Yaw angle [Degree]')
legend('Estimated','Reference','FontSize',8)
saveas(gcf,'mag_estimations.pdf')