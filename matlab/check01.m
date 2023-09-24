close all 
clear all

load coefficients.mat % load the coefficients of amplifier
load ideal_carrier_dpd_data.mat

pd_c = [0; 1.25; 0; 0.11347656];
pd_cnew = [0; 1; 0; 0.072625];

%% check 1
%xl = x([find(x(1:end)<=1&x(1:end)>=-1)]); 

xin = x.';
xin = xin/10;
X = [xin.^0, xin.^1, xin.^2, xin.^3];
xc = X*pd_c;
Z = [xc.^0, xc.^1, xc.^2, xc.^3];
ys = Z*c; % output with pdp and k1 is 1

Z1 = [xin.^0, xin.^1, xin.^2, xin.^3];
yn = Z1*c; % Output without pdp

xc_new = X*pd_cnew;
Z_new = [xc_new.^0, xc_new.^1, xc_new.^2, xc_new.^3];
ys_new = Z_new*c; % output with pdp and k1 is 0.8


figure(1);
plot(xin, ys, '-.g');
% xlim([-1 1]);
hold on

plot(xin, yn, '-.r');

hold on

plot(xin, ys_new, '-.b');


%% check 2
Y = fft(ys_new);
% stem(abs(Y));
% fmax = 1/0.125;
% Ts = 0.125;
% fmax = 1/(2*Ts);
Ts = t(2);
fs = 1/Ts;
% Ttotal = length(ys_new)/2 * Ts;
deltaF = fs/length(ys_new);

% Nsamps =     length(ys_new);

% fvec = (- length(Y)/2 : length(Y)/2 - 1) * fs/length(Y); 
% fvec = fs*(0:Nsamps-  1)/Nsamps;
% fvec = - fs : deltaF : fs - deltaF;
fvec = - fs/2 : deltaF : fs/2 - deltaF;
% fvec = - length(Y)/2 : 1 : length(Y)/2 - 1;
% fvec = 1/length(t);

stem(fvec, fftshift(20*log10(abs(Y))), 'BaseValue', -300);
hold on


%% check 3 fft 2
Ts = t(2);
fs = 1/Ts;
ydft = fft(ys_new);
ty = length(ys_new) * Ts;
fy = 1/ty;
yfv = - fs/2 : fy : fs/2 - fy ; 
stem(yfv, fftshift(20*log10(abs(ydft))), 'BaseValue', -300);
hold on

%ydft = ydft(1:length(ys_new)/2+1);% half the signal fft


Ts = t(2);
fs = 1/Ts;
ydft = fft(ys_new); % get the fft of output y_new(the output signal got from whole system)
DF = fs/length(ys_new); % frequency increment
freqvec = -fs/2 : DF : fs/2 - DF; % Get the frequency vector
subplot(2,1,1);
plot(freqvec, fftshift(20*log10(abs(ydft))));
title('FFT from plot function');
hold on
subplot(2,1,2);
stem(freqvec, fftshift(20*log10(abs(ydft))), 'BaseValue', -300);
title('FFT from stem function');


Ts = t(2);
fs = 1/Ts;
ydft_n = fft(yn); % get the fft of output y_new(the output signal got from whole system)
DF_n = fs/length(yn); % frequency increment
freqvec_n = -fs/2 : DF_n : fs/2 - DF_n;
%subplot(2,1,1);
plot(1);
stem(freqvec_n, fftshift(20*log10(abs(ydft_n))), 'BaseValue', -300, 'Marker','+');
% title('FFT of orginal y');
hold on
%subplot(2,1,2);
stem(freqvec, fftshift(20*log10(abs(ydft))), 'BaseValue', -300);
% title('FFT of y with predistortion');



Xf = fft(xin);
tt = length(xin)/2 * Ts;
df = 1/tt;
xfv = - fs : df : fs - df; 
stem(xfv, fftshift(20*log10(abs(Xf))), 'BaseValue', -300);
hold on

Xf = fft(xin);
tt = length(xin)/2 * Ts;
df = 1/tt;
xfv = - fs : df : fs - df; 
stem(xfv, fftshift(20*log10(abs(Xf))), 'BaseValue', -300);
hold on