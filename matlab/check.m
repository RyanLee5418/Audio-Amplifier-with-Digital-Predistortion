load coefficients.mat
load ideal_carrier_dpd_data.mat

%t = 0:0.125:0.875;
%fsig = 1;
% x = sin(2*pi*fsig*t);
% plot(t,y,'o');

% n = [0; 0.8; 0; -0.0581];
n = [0; 1.25; 0; 0.11347656];
n_new = [0; 1; 0; 0.072625];

%% check 1
xin = x.';
X = [xin.^0, xin.^1, xin.^2, xin.^3];
xc = X*n;
Z = [xc.^0, xc.^1, xc.^2, xc.^3];
ys = Z*c; % output with pdp and k1 is 1

Z1 = [xin.^0, xin.^1, xin.^2, xin.^3];
yn = Z1*c; % Output without pdp

xc_new = X*n_new;
Z_new = [xc_new.^0, xc_new.^1, xc_new.^2, xc_new.^3]
ys_new = Z_new*c; % output with pdp and k1 is 0.8


figure(1);
plot(x, ys, '-.g');
xlim([-1 1]);
hold on

plot(x, yn, '-.r');

hold on

plot(x, ys_new, '-.b');


%% check 2
Y = fft(ys_new);
fmax = 1/0.125;
Ts = t(2);
fs = 1/Ts;
Ttotal = 1/2 * length(t) * Ts;
deltaF = 1/Ttotal;

fvec = - fs : deltaF : fs - deltaF;

stem(fvec, fftshift(20*log10(abs(Y))), 'BaseValue', -300);
hold on