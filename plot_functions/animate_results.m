function animate_results(constraints)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
load('vals');

positions = get_positions(constraints);

XMIN=-2;
XMAX=2;
YMIN=-2;
YMAX=2;

stored_th1=stored_states(constraints.start_node:end,3);
stored_th2=stored_states(constraints.start_node:end,4);
truth_th1=constraints.truth_data.th1(constraints.start_node:end);
truth_th2=constraints.truth_data.th1(constraints.start_node:end);


l1=constraints.l1_val;
l2=constraints.l2_val;
figure();
for i=1:1:length(stored_th1)
    th1=stored_th1(i);
    th2=stored_th2(i);

    clf
    plot([subs(positions.P0(1,1)),subs(positions.P1(1,1))],[subs(positions.P0(3,1)),subs(positions.P1(3,1))],'b');
    hold on
    plot([subs(positions.P0(1,2)),subs(positions.P1(1,2))],[subs(positions.P0(3,2)),subs(positions.P1(3,2))],'r');
    
    
    
    th1=truth_th1(i);
    th2=truth_th2(i);
    
    plot([subs(positions.P0(1,1)),subs(positions.P1(1,1))],[subs(positions.P0(3,1)),subs(positions.P1(3,1))],'k');
    plot([subs(positions.P0(1,2)),subs(positions.P1(1,2))],[subs(positions.P0(3,2)),subs(positions.P1(3,2))],'k');
    
    axis([XMIN XMAX YMIN YMAX]);
    pause(0.01);
end
end

