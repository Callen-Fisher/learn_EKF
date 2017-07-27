function optimise_EKF(constraints)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
num_vars=2;
x0=ones(num_vars,1)*0.01;
lb=zeros(num_vars,1);
ub=10*ones(num_vars,1);
initCond=x0;

global mydata;
mydata.constraints=constraints;

options = optimoptions(@fmincon,'Algorithm','interior-point','display','iter','MaxFunEvals',15000,'MaxIter',7000,...
    'FinDiffRelStep',1e-4, 'TolFun', 1e-4, 'TolX', 1e-4,'diffminchange',1e-4,'UseParallel','always');
warning('off');
problem = createOptimProblem('fmincon','x0',initCond,'objective',@tracklsq,...
    'lb',lb,'ub',ub,'options',options);
gs = GlobalSearch('Display','iter','NumTrialPoints',300);
[x,f]=run(gs,problem);
vals=x;

v1=vals(1);
v2=vals(2);
[cost,stored_states]=EKF(constraints,v1,v2);

save('results/vals','vals','mydata','stored_states')


 %% run the optimisation
    function cost = tracklsq(vals)
        mydata;
        temp_constraints=mydata.constraints;
        
        val1=vals(1);
        val2=vals(2);
        
        [cost,states]=EKF(temp_constraints,val1,val2);
    end
end

