function main(command)
%MAIN start of code
%   Enter a command to run sections of the code. Possible commands include
%   the following:
%       main('setup'): sets up all the paths so the files all run
%       main('plot_dynamics'): plots the dynamics
%       main('gen_EKF'): generates the EKF functions
%       main('optimise'): optimises the R and Q matrix
%       main('animate_results'):animate the optimised results
%
%
% Please read the readme for further information
% 
% Coded by Callen Fisher, 2017, UCT
% any queries contact me: callenfisher5@gmail.com

%% check if the user has entered a command
if(nargin==0)
    command='';
end

%% setup command
if(strcmp(command,'setup'))
    disp('setup command called');
    addpath('plot_functions');
    addpath('EOM_functions');
    addpath('EKF_functions');
    addpath('constraints');
    addpath('optimise');
    addpath('results');
    disp('setup command finished');
%% plot_dynamics
elseif(strcmp(command,'plot_dynamics'))
    disp('plot_dynamics command called');
    constraints=get_constraints();
    plot_dynamics(constraints);
    disp('plot_dynamics command finished');
%% gen_EKF
elseif(strcmp(command,'gen_EKF'))
    disp('gen_EKF command called');
    constraints=get_constraints();
    generate_EKF(constraints);
    disp('gen_EKF command finished');
%% optimise
elseif(strcmp(command,'optimise'))
    disp('optimise command called');
    constraints=get_constraints();
    optimise_EKF(constraints);
    disp('optimise command finished');
%% animate_results
elseif(strcmp(command,'animate_results'))
    disp('animate_results command called');
    constraints=get_constraints();
    animate_results(constraints);
    disp('animate_results command finished');
%% No command entered
else
    disp('No command was entered. Please read the readme file, or type help main in matlab')
end

end

