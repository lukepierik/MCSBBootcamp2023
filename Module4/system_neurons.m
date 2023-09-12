%Try the Circshift Method


%Parameters
epsilon = .08;
a = 1;
b = .2;
D = .9;

%Simulation Steps
N = 10;
tStart = 40;
tStop = 47;
I0 = zeros(1,N)';
I0(4) = 1;
I = @(t) I0.*(t>tStart).*(t<tStop);

%ODE System
dvdt = @(t,v,w) v - (1./3)*v.^3 - w +  I(t) + D.*(circshift(v,1) -2.*v + circshift(v,-1));
dwdt = @(t,v,w) epsilon.*(v + a - b.*w);

dxdt = @(t,X)[dvdt(t,X(1:N), X(N+1:2*N));
              dwdt(t,X(1:N), X(N+1:2*N))];

v0 = zeros(N,1);
u0 = zeros(N,1);
X0 = [v0; u0];

[T, Y] = ode45(@(t,X) dxdt(t,X), [0,100], X0);

OUT_v = Y(:,2:N+1);

clf
for i = 1:length(T)
    movieVector = getframe;
    currframe = plot(i,OUT_v(i,:));
    currframe = getframe
    
end
movieVector


