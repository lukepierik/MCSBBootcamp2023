% ------------------------------------------------------
A     = 1.1; % fluorescence intensity units
omega = 2.6; % rad/s
A_0   = 0.01;

%diff = @(u1,u2)

u=@(t) A*sin(omega*t)+A_0;

tArray = linspace(0,1.6,200);
uArray = u(tArray); % an array of samples of u
% ------------------------------------------------------

% analytical solutions (in real life, we might not know these)
dudtExact      =  A*omega*cos(omega*tArray);
du2dt2Exact    = -A*omega^2*sin(omega*tArray);
du3dt3Exact    = -A*omega^3*cos(omega*tArray);


dt = tArray(2)-tArray(1); 
dudt = diff(uArray)/dt;

% Take the sample and add a bit of noise
uObserved = u(tArray) + (1e-7)*randn(size(tArray));
 
display(uObserved);

figure;
plot(tArray,uObserved, '+')
hold on
plot(tArray(1:end-1),diff(u(tArray))./dt)
hold off

function diff_vec = diff(array1)
diff_vec = 1:length(array1)-1;
for i = 2:length(array1)
    diff = array1(i) - array1(i-1);
    diff_vec(i-1) = diff;
end
end

