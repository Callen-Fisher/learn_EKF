function positions = get_positions(constraints)
%GET_POSITIONS calculates the positions
%   Calculates the positions of the links for a two link planar pendulum.
%   The positions are [x;y;z] where y will always be zero. P0 represents
%   the base of the link, P1 the tip of the link and PCOM the COM of the
%   link. The positions are vectors, the first vector is the first link and
%   the second vector is the second link

positions.P0(:,1)=constraints.origin;
positions.P1(:,1)=positions.P0(:,1)+R(constraints.th1)*[constraints.l1;0;0];
positions.PCOM(:,1)=positions.P0(:,1)+R(constraints.th1)*constraints.l1_com*[constraints.l1;0;0];

positions.P0(:,2)=positions.P1(:,1);
positions.P1(:,2)=positions.P1(:,1)+R(constraints.th2)*[constraints.l2;0;0];
positions.PCOM(:,2)=positions.P1(:,1)+R(constraints.th2)*constraints.l2_com*[constraints.l2;0;0];
end

