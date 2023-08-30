%Bootcamp
clc;clear;

% How much caffeine is there in the jar?

% n - number of days
nMax = 400; % max number of days to simulate
r_vec = linspace(0,3,60);
K = .6;
x0 = .2;


for r = r_vec
    logOUT = logistic(r,K,nMax,x0);
    plot(r,logOUT,'-or');
    hold on
end

ylabel('attractors')
xlabel('r')

function logOUT = logistic(r,K,nMax,x0)
x2 = x0;
for n=2:(nMax./2)
    x2 = x2 + r.*(1-(x2./K)).*x2;
end % finished loop through days

%finding the steady states
finalsteps = nMax - nMax./2;
x2_vec =1:finalsteps;  %just a vector
x2_vec(1) = x2;
for n=2:finalsteps
    x2_vec(n) = x2_vec(n-1) + r.*(1 - x2_vec(n-1)./K).*x2_vec(n-1);
end
logOUT = x2_vec;
end