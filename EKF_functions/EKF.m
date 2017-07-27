function [cost,stored_states]=EKF(constraints,val1,val2)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
link_data=[constraints.l1_val;constraints.l2_val;constraints.l1_com_val;constraints.l2_com_val;constraints.m1_val;constraints.m2_val;constraints.g_val;constraints.mag_vec_val];
Q=diag([val1,val2,0,0]);
I=eye(length(constraints.start_states));
states=constraints.start_states;
covP=constraints.covP;
R=constraints.R;
for i=constraints.start_node:1:length(constraints.sensor_data.acc1(1,:))
    dq=states(1:length(states));
    q=states(length(states)/2+1:end);
    predict_dx_Eq=predictDxFunctionEKF(dq,q,link_data);
   
    d_F_matrix=dFfunctionEKF(dq,q,link_data);
    F_matrix=I+constraints.sampleTime*d_F_matrix;
    
    states = states+constraints.sampleTime*predict_dx_Eq';
    
    covP = (F_matrix)*(covP*(F_matrix')) + Q;
   
    ddq=predict_dx_Eq.';
    dq=states(1:length(states));
    q=states(length(states)/2+1:end);
    update_Eq=updateFunctionEKF(ddq,dq,q,link_data);
    
    H_matrix=HfunctionEKF(ddq,dq,q,link_data);
    
    K=(covP*H_matrix')/(H_matrix*covP*H_matrix'+R);
   
    z=[constraints.sensor_data.acc1(1,i),constraints.sensor_data.acc1(3,i),constraints.sensor_data.gyro1(2,i),constraints.sensor_data.mag1(1,i),constraints.sensor_data.mag1(3,i),...
       constraints.sensor_data.acc2(1,i),constraints.sensor_data.acc2(3,i),constraints.sensor_data.gyro2(2,i),constraints.sensor_data.mag2(1,i),constraints.sensor_data.mag2(3,i)]'; 
    
   
    
    states=states+K*(z-update_Eq');
    covP=(I-K*H_matrix)*covP;
    
    stored_states(i,:)=states(:)';
end

cost= sum(sum((stored_states(constraints.start_node:end,1)-constraints.truth_data.dth1(constraints.start_node:end)').^2) +...
          sum((stored_states(constraints.start_node:end,2)-constraints.truth_data.dth2(constraints.start_node:end)').^2) +...
          sum((stored_states(constraints.start_node:end,3)-constraints.truth_data.th1(constraints.start_node:end)').^2) +...
          sum((stored_states(constraints.start_node:end,4)-constraints.truth_data.th2(constraints.start_node:end)').^2));
end

