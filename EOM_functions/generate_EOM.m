function [ddq,positions,velocities,accelerations] = generate_EOM(constraints)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
q=constraints.q;
dq=constraints.dq;
ddq=constraints.ddq;
%% get the inertial matrix
J_1=[[0 0 0];[0 constraints.m1*constraints.l1^2/12+(constraints.l1_com-0.5)*constraints.l1^2*constraints.m1 0];[0 0 0]];
J_2=[[0 0 0];[0 constraints.m2*constraints.l2^2/12+(constraints.l2_com-0.5)*constraints.l2^2*constraints.m2 0];[0 0 0]];
%% get the positions
positions=get_positions(constraints);
%% get the velocities
velocities.P1(:,1)=jacobian(positions.P1(:,1),q)*dq;
velocities.P1(:,2)=jacobian(positions.P1(:,2),q)*dq;

velocities.P0(:,1)=jacobian(positions.P0(:,1),q)*dq;
velocities.P0(:,2)=jacobian(positions.P0(:,2),q)*dq;

velocities.PCOM(:,1)=jacobian(positions.PCOM(:,1),q)*dq;
velocities.PCOM(:,2)=jacobian(positions.PCOM(:,2),q)*dq;
%% get the accelerations
accelerations.P1(:,1)=jacobian(velocities.P1(:,1),q)*dq+jacobian(velocities.P1(:,1),dq)*ddq;
accelerations.P1(:,2)=jacobian(velocities.P1(:,2),q)*dq+jacobian(velocities.P1(:,2),dq)*ddq;

accelerations.P0(:,1)=jacobian(velocities.P0(:,1),q)*dq+jacobian(velocities.P0(:,1),dq)*ddq;
accelerations.P0(:,2)=jacobian(velocities.P0(:,2),q)*dq+jacobian(velocities.P0(:,2),dq)*ddq;

accelerations.PCOM(:,1)=jacobian(velocities.PCOM(:,1),q)*dq+jacobian(velocities.PCOM(:,1),dq)*ddq;
accelerations.PCOM(:,2)=jacobian(velocities.PCOM(:,2),q)*dq+jacobian(velocities.PCOM(:,2),dq)*ddq;
%% calculate the energies
% linear kinetic energy
T=1/2*constraints.m1*(velocities.PCOM(:,1).')*velocities.PCOM(:,1);
T=T+1/2*constraints.m2*(velocities.PCOM(:,2).')*velocities.PCOM(:,2);
% rotational kinetic energy
T=T+1/2*([0;dq(1);0].')*J_1*[0;dq(1);0];
T=T+1/2*([0;dq(2);0].')*J_2*[0;dq(2);0];
% potential energy
V=constraints.m1*constraints.g*positions.PCOM(3,1);
V=V+constraints.m1*constraints.g*positions.PCOM(3,2);
%% calculate the generalized forces
Q=[0;0];
%% Mass Matrix
M  = sym('M', length(q));                                             
M=jacobian(jacobian(T,dq).',dq);                               
M = simplify(M);                                                                                                           
%% Coriolis and Centripetal Terms
C  = sym(zeros(length(q)));                                            
for i = 1:length(q(:))                                                 
    for j = 1:length(q(:))
        for m = 1:length(q(:))
            C(i,j) = C(i,j)+ 0.5*(diff(M(i,j),q(m)) + diff(M(i,m),q(j)) - diff(M(j,m),q(i)))*dq(m);
        end
    end
end
C = simplify(C);                                                         
%% Gravitational Terms                              
G  = sym('G',[length(q) 1]);                                           
for i = 1:length(q(:))
    G(i) = diff(V,q(i));                                           
end
G = simplify(G);                                                                                                                          
%% calc ddq
ddq=((M)\(-C*dq - G + Q));
end

