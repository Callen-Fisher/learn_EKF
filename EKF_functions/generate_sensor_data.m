function [truth_data,sensor_data] = generate_sensor_data(constraints)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

sim('simulate_data');

q_data=q.signals.values().';
dq_data=dq.signals.values().';
gyro_data=gyro.signals.values().';
mag_data=mag.signals.values().';
acc_data=acc.signals.values().';

truth_data.th1=q_data(1,:);
truth_data.th2=q_data(2,:);
truth_data.dth1=dq_data(1,:);
truth_data.dth2=dq_data(2,:);


sensor_data.acc1=acc_data(1:3,:);
sensor_data.acc2=acc_data(4:6,:);
sensor_data.gyro1=gyro_data(1:3,:);
sensor_data.gyro2=gyro_data(4:6,:);
sensor_data.mag1=mag_data(1:3,:);
sensor_data.mag2=mag_data(4:6,:);

end

