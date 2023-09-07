%Plot for the derivatives

u=@(t) A*sin(omega*t)+A_0;

A     = 1.1; % fluorescence intensity units
omega = 2.6; % rad/s
A_0   = 0.01;
tArray = linspace(0,1.6,200);


dudtExact      =  A*omega*cos(omega*tArray);
du2dt2Exact    = -A*omega^2*sin(omega*tArray);
du3dt3Exact    = -A*omega^3*cos(omega*tArray);

%first Derivative
dudt = diff(u(tArray))./dt;

plot(tArray(1:end-1),dudt)
hold on

%Second Derivative
d2ud2t = diff(dudt)./dt;
plot(tArray(1:end-2),d2ud2t)
hold on
%Third Derivative
d3ud3t = diff(d2ud2t)./dt;
plot(tArray(1:end-3),d3ud3t)
hold off

legend('d1','d2','d3')
function diff_vec = diff(array1)
diff_vec = 1:length(array1)-1;
for i = 2:length(array1)
    diff = array1(i) - array1(i-1);
    diff_vec(i-1) = diff;
end
end
