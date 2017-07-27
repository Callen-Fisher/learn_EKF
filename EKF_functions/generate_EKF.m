function generate_EKF(constraints)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
link_data=[constraints.l1;constraints.l2;constraints.l1_com;constraints.l2_com;constraints.m1;constraints.m2;constraints.g;constraints.mag_vec];
dq=constraints.dq;
q=constraints.q;
%% define the states
states=constraints.states;
%% get the system equations
[ddq,positions,velocities,accelerations]=generate_EOM(constraints);
%% simplify the equations
temp_ddq(1)=simplify(ddq(1));
temp_ddq(2)=simplify(ddq(2));
ddq=temp_ddq;
clear temp_ddq;
%% the F matrix
predict_dx_equations=[ddq(1),ddq(2),constraints.dth1,constraints.dth2];%integrate to get states %small f
dF = jacobian(predict_dx_equations,states);
vars={dq,q,link_data};
matlabFunction(dF,'file','EKF_functions/dFfunctionEKF','Vars',vars);
matlabFunction(predict_dx_equations,'file','EKF_functions/predictDxFunctionEKF','Vars',vars);
%% the H matrix
acc1=R(constraints.th1).'*[0;0;constraints.g]+R(constraints.th1).'*accelerations.P1(:,1);%acc measures the gravity vector in the body frame and the acc in body frame
acc2=R(constraints.th2).'*[0;0;constraints.g]+R(constraints.th2).'*accelerations.P1(:,2);
gyro1=[0;constraints.dth1;0];% gyro measures the angular rate
gyro2=[0;constraints.dth2;0];
mag1=R(constraints.th1).'*constraints.mag_vec;% rotate the magnetic vector into the body frame
mag2=R(constraints.th2).'*constraints.mag_vec;

disp('the H matrix');
update_equations=[acc1(1),acc1(3),gyro1(2),mag1(1),mag1(3),acc2(1),acc2(3),gyro2(2),mag2(1),mag2(3)];
H = jacobian(update_equations,states);

syms ddth1 ddth2
temp_sym_ddq=[ddth1;ddth2];
vars={temp_sym_ddq,dq,q,link_data};

matlabFunction(H,'file','EKF_functions/HfunctionEKF','Vars',vars);
matlabFunction(update_equations,'file','EKF_functions/updateFunctionEKF','Vars',vars);

end

