close all 
clear all

% load coefficients.mat % load the coefficients of amplifier
% load coeffs_updated.mat % load the updated coefficients
load ideal_carrier_dpd_data.mat % load the input signal

[cc,d] = amplifier_model_extraction(x, y); 

% pd_c = [0; 1.25; 0; 0.11347656];
% pd_cnew = [0; 1; 0; 0.072625];

c_new = [0; 8; 1; -0.581; 0; 0]; % set an amplifier model with c2 != 0

c = [0; 8; 1; -0.581]; 

n = [0; 1; -0.125; 0.103875; -0.05515625; 0.04307121875]; % DPD model

total_c1 = 8;

pd_cnew = updated_dpdmodel(c_new, total_c1); % call the DPD update function

%% Check 1 Time Domain
xin = x.';
xin = xin/5; % scale the xin
X = [xin.^0, xin.^1, xin.^2, xin.^3, xin.^4, xin.^5];

% Output with pdp and k1 is 1
% xc = X*pd_c; % be processed in dpd  
% Z = [xc.^0, xc.^1, xc.^2, xc.^3];
% ys = Z*c; % be processed in amplifier

% Output without dpd
%X = [xin.^0, xin.^1, xin.^2, xin.^3];
yn = X*c_new; % be processed in amplifier

% Output with pdp and total_c1 is 8
xc_new = X*pd_cnew;
Z_new = [xc_new.^0, xc_new.^1, xc_new.^2, xc_new.^3];
ys_new = Z_new*c; 

% 
mdl = X * [0; 8; 0; 0; 0; 0];


% Plot the signals in time domain
figure(1);


%plot(xin, ys, '-.g'); % Green: with k1 = 1(the first order coeff of whole sys)
%hold on
plot(xin, yn, '-.r'); % Red: without dpd
hold on
plot(xin, ys_new, '-.b'); % Blue: with total_c1 = 8(the first order coeff of whole sys)
hold on
%
plot(xin, mdl, '-.g');
hold on
%
title('Time Domain Check between Original Amplifier and DPD System')
xlabel('Input Signal')
ylabel('Output Signal')
legend('Original Amplifier', 'DPD System', 'Ideal linear Amplifier')

% R-square value calculation
totalSumOfSquaresForConstantModel = sum((ys_new - mean(ys_new)).^2);
sumOfSquaresForLinearModel = sum((ys_new - mdl).^2);
Rsq = 1 - sumOfSquaresForLinearModel/totalSumOfSquaresForConstantModel

totalSumOfSquaresForConstantModel1 = sum((yn - mean(yn)).^2);
sumOfSquaresForLinearModel1 = sum((yn - mdl).^2);
Rsq1 = 1 - sumOfSquaresForLinearModel1/totalSumOfSquaresForConstantModel1


%% Check 2 FFT(one signal)
% the output signal from whole system(with pdp pd_cnew coeffs) 
Y = fft(ys_new);
Ts = t(2);
fs = 1/Ts;
deltaF = fs/length(ys_new); % frequency increment
fvec = - fs/2 : deltaF : fs/2 - deltaF; % frequency vector
stem(fvec, fftshift(20*log10(abs(Y))), 'BaseValue', -300); 
hold on


%% Check 3 FFT(signals comparison)

% The fft comparison between the output with dpd and without dpd 
Y_n = fft(yn); % get the fft of output yn(the output signal without dpd)
DF_n = fs/length(yn); % frequency increment
freqvec_n = -fs/2 : DF_n : fs/2 - DF_n; % get the frequency vector
plot(1);
% The fft of output without dpd (with + mark and blue colour)
stem(freqvec_n, fftshift(20*log10(abs(Y_n))), 'BaseValue', -300, 'Marker','+');
hold on
% The fft of output with dpd (without mark and orange colour)
stem(fvec, fftshift(20*log10(abs(Y))), 'BaseValue', -300);
title('FFT Check between Original Amplifier and DPD System')
xlabel('Frequency')
ylabel('Amplitude')
legend('Original Amplifier', 'DPD System');



% The fft plot comparison between plot and stem functions
subplot(2,1,1);
plot(fvec, fftshift(20*log10(abs(Y))));
title('FFT from plot function');
hold on
subplot(2,1,2);
stem(fvec, fftshift(20*log10(abs(Y))), 'BaseValue', -300);
title('FFT from stem function');