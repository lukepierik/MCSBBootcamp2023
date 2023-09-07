%Print here

%system of equations

%Parameters
konA = 10;
koffA = 10;
konI = 10;
koffI = 10;
kcatI = 10;
kcatA = 100;

PTOT = 1;
%KTOT = 1;
KTOT_VEC = 10.^linspace(-3,2,100);
ITOT = 100;
TFINAL = 100;

iter = 1;
active_protein = zeros(1,length(KTOT_VEC));
for KTOT = KTOT_VEC
    f = @(A,AP,I,IK) -konA.*(PTOT - AP).*A + koffA.*(AP) + kcatA.*(IK); % dA/dt
    g = @(A,AP,I,IK)  konA.*(PTOT - AP).*A - koffA.*(AP) - kcatI.*(AP); % dAP/dt
    a = @(A,AP,I,IK) -konI.*(KTOT - IK).*I + koffI.*(IK) + kcatI.*(AP); % dI/dt
    b = @(A,AP,I,IK)  konI.*(KTOT - IK).*I - koffI.*(IK) - kcatA.*(IK); % dIK/dt

    dxdt = @(t,x)[f(x(1),x(2),x(3),x(4));
                  g(x(1),x(2),x(3),x(4));
                  a(x(1),x(2),x(3),x(4));
                  b(x(1),x(2),x(3),x(4))];

    [T, X] = ode45(dxdt, [0,TFINAL], [0,0,ITOT,0]);
    active_protein(iter) = X(end,1) + X(end,2);
    iter = iter + 1;
end

%plot(KTOT_VEC, active_protein)
%xlim([0 10])
semilogx(KTOT_VEC, active_protein)
% 
% figure; hold on;
% plot(T,X(:,1),'-r'); % red for RNA
% plot(T,X(:,2),'-', 'color', [0.5 0 1]); % purple for protein
% plot(T,X(:,3));
% plot(T,X(:,4));
% ylabel('Production of protein/enzyme')
% xlabel('Time')

