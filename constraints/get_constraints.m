function constraints = get_constraints()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

syms th1 th2 l1 l2 l1_com l2_com
syms dth1 dth2 ddth1 ddth2 m1 m2
syms g t magVecX magVecY magVecZ


constraints.origin=sym([0;0;0]);
constraints.sampleTime=0.01;
constraints.start_states=[0;0;pi/2;pi/2];
constraints.covP=diag([1,1,1,1]);
constraints.start_node=10;

warning('get_constraints: fix the R matrix')
constraints.R=diag([0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1]);
%% parameters and their values (use in the plot functions) 
constraints.l1=l1;
constraints.l1_val=1;% please change this in the simulink mode as well
constraints.l1_com=l1_com;
constraints.l1_com_val=0.5;

constraints.l2=l2;
constraints.l2_val=1;% please change this in the simulink mode as well
constraints.l2_com=l2_com;
constraints.l2_com_val=0.5;

constraints.th1_val=pi/4;
constraints.th2_val=pi/4;

constraints.m1=m1;
constraints.m1_val=1;
constraints.m2=m2;
constraints.m2_val=1;

constraints.g=g;
constraints.g_val=9.81;% please change this in the simulink mode as well

%constraints.t=t;
%constraints.t_max=7;

constraints.mag_vec=[magVecX;magVecY;magVecZ];
constraints.mag_vec_val=[0.7071;0;0.7071];% please change this in the simulink mode as well
%% coordinates
constraints.th1=th1;
constraints.th2=th2;
constraints.dth1=dth1;
constraints.dth2=dth2;
constraints.ddth1=ddth1;
constraints.ddth2=ddth2;

constraints.q=   [constraints.th1;   constraints.th2];
constraints.dq=  [constraints.dth1;   constraints.dth2];
constraints.ddq= [constraints.ddth1;   constraints.ddth2];
%% get the data
[truth_data,sensor_data] = generate_sensor_data(constraints);
constraints.truth_data=truth_data;
constraints.sensor_data=sensor_data;
%% filter state
constraints.states=[constraints.dth1 constraints.dth2 constraints.th1 constraints.th2];
end

