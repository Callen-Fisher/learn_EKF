function plot_dynamics(constraints)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

disp('Plotting the model: two link pendulum. change the angle values in get_constraints')

positions = get_positions(constraints);
th1=constraints.th1_val;
th2=constraints.th2_val;
l1=constraints.l1_val;
l2=constraints.l2_val;

plot([subs(positions.P0(1,1)),subs(positions.P1(1,1))],[subs(positions.P0(3,1)),subs(positions.P1(3,1))],'b');
hold on
plot([subs(positions.P0(1,2)),subs(positions.P1(1,2))],[subs(positions.P0(3,2)),subs(positions.P1(3,2))],'r');

XMIN=-2;
XMAX=2;
YMIN=-2;
YMAX=2;

axis([XMIN XMAX YMIN YMAX]);
end

