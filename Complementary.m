clear all;
fid = fopen('IMU_datasets/Roll.csv');
out = textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter',',');
fclose(fid);

time = out{1};
ref_roll = [time out{2}];
ref_pitch = [time out{3}];
ref_yaw = [time out{4}];

acc_x = [time out{5}];
acc_y = [time out{6}];
acc_z = [time out{7}];

gyro_x = [time out{8}];
gyro_y = [time out{9}];
gyro_z = [time out{10}];

mag_x = [time out{11}];
mag_y = [time out{12}];
mag_z = [time out{13}];


figure
plot(time, ref_roll(:,2),time, ref_pitch(:,2),time, ref_yaw(:,2))

figure
plot(time, acc_x(:,2), time, acc_y(:,2),time, acc_z(:,2))

figure 
plot(time, mag_x(:,2),time, mag_y(:,2),time, mag_z(:,2))


