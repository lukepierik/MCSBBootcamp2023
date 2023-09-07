
clc;clear;
%Global Paramters
TF = 100;

%Model Parameters
lambda = 1;
theta = 10.^3;
alpha = 2;
N0 = 200;

%ode for growth
dNdt = @(N) lambda.*N.*(1-(N./theta).^alpha); % Define the ODE 
f = @(t,x) dNdt(x(1));

[T, P] = ode45(f, [0,TF], N0); % Matlab's built-in ODE solver, ode45

[T2,N2] = GrowthCurve(lambda,theta,alpha,N0,TF);

%plot(T,P)

%% Load in data
table = readtable("growthdata.csv");
times = table{1:7,"Time"}; %Heading label
experiment = table{1:7,"Temp2_B"};

plot(times,experiment,'*','markersize',12)
hold on
%% Search for best fit curve
%SSE_test = @(x) SSE(experiment,times,x(1),x(2),x(3),N0);
SSE_test = @(x) SSE(experiment,times,x(1),x(2),x(3),N0);

%x0 = [lambda,theta,alpha];
x0 = [.015,30,100];
%Guess 1: 0.0212    0.4568   20.4312
x = fminsearch(SSE_test,x0);

[T3,N3] = GrowthCurve(x(1),x(2),x(3),.08,174);
plot(T3,N3,'linewidth',6)
%ylim([0,1])
hold off

%SSE(experiment, times, lambda,theta,alpha,N0)

%[T, P] = ode45(f, [0,times(end)], N0); % Matlab's built-in ODE solver, ode45

%[T,N] = GrowthCurve(lambda,theta,alpha,N0,times(end));

%[T,N] = GrowthCurve(x(1),x(2),x(3),N0,times(end));
%plot(T,N,'linewidth',6)
%ylim([0,1])


%% Code for SSE

function SSE = SSE(vec_exp,time_vec,lambda,theta,alpha,N0)

% ODE for growth
dNdt = @(N) lambda.*N.*(1-(N./theta).^alpha); % Define the ODE 
f = @(t,x) dNdt(x(1));
[~,vec_sim] = ode45(f, time_vec, N0);

% Calculate SSE
squares = (vec_exp - vec_sim).^2;
SSE = sum(squares);
end

function [T,P] = GrowthCurve(lambda,theta,alpha,N0,TF)
dNdt = @(N) lambda.*N.*(1-(N./theta).^alpha); % Define the ODE 
f = @(t,x) dNdt(x(1));
[T, P] = ode45(f, [0,TF], N0); % Matlab's built-in ODE solver, ode45
end