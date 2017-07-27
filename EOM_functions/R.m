function rot = R(th)
%R Rotation matrix
%   returns the rotation matrix. Currently only for the pitch case, later
%   modify for roll and yaw angles. This was coded by Callen Fisher, UCT
%   2017. callenfisher5@gmail.com
rot=[[cos(th) 0 sin(th)];[0 1 0];[-sin(th) 0 cos(th)]];

end

