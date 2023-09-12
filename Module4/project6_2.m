%Project 6.2: FitzHugh - Nagumo

%Parameters
epsilon = .08;
a = 1;
b = .2;

%Impulse Function

I0 = 1.0;
tStart = 40;
tStop = 47;
I = @(t) I0.*(t>tStart).*(t<tStop);

%ODE System
dvdt = @(t,v,w) v - (1./3).*v.^3 - w + I(t);
dwdt = @(t,v,w) epsilon.*(v + a - b.*w);

dxdt = @(t,x)[dvdt(t,x(1),x(2));
              dwdt(t,x(1),x(2))];

[T, X] = ode45(dxdt, [0,100], [-1.13, -.649] );

figure; hold on;
plot(T,X(:,1)); % red for RNA
plot(T,X(:,2),'-')
ylabel('voltage or ion activity')
xlabel('time')




