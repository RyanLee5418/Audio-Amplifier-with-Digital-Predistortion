close all;
clear all;

%% Upsampling 
% Upsampling Parameters
upsamfac = 15;

% Original Sampling parameters
Fs_original = 150;
T_original = 1/Fs_original;

% Upsampled sampling parameters
Fs_target = Fs_original * upsamfac;       % Target upsampled sampling frequency
T_target = 1/Fs_target; 

% Signal parameters
duration = 1;   % Duration(seconds)
f = 10;         % Signal frequency

% Set the time vectors 
t_original = 0:T_original:duration-T_original;                       
t_upsampled = 0:(T_original/upsamfac):(duration-T_original/upsamfac); 
t_filtered = 0:(T_original/upsamfac):(duration - T_original/upsamfac);
t_filtered1 = t_filtered(51:2250);

% Generate the original sinewave signal
original = sin(2*pi*f*t_original);

% Upsample the signal
upsampled = upsample(original, upsamfac);

%% Filtering
% Design the low-pass filter
cutoffFreq = 75;  % Cutoff frequency of the low-pass filter in Hz
normalizedCutoffFreq = cutoffFreq / (Fs_target/2);  % Normalized cutoff frequency
filterOrder = 100;  % Order of the filter

% Design the filter coefficients
filterCoeffs = fir1(filterOrder, normalizedCutoffFreq);

% Apply the low-pass filter to the upsampled signal
filtered = filtfilt(filterCoeffs, 1, upsampled);

%% Time Domain and FFT check
% Plot the original signal in time domain
subplot(2, 3, 1);
plot(t_original, original);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Signal (Time Domain)');

% Plot the upsampled signal in time domain
subplot(2, 3, 2);
plot(t_upsampled, upsampled);
xlabel('Time (s)');
ylabel('Amplitude');
title('Upsampled Signal (Time Domain)');

% Plot the filtered signal in time domain
% filtered1 = filtered(51:2250);
% fft_filtered = fft(filtered1);

subplot(2, 3, 3);
plot(t_filtered, filtered);
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Signal (Time Domain)');

% Compute the FFT of the original signal
subplot(2, 3, 4);
fft_original = fft(original);
deltaF_original = Fs_original/length(original); % frequency increment
fvec_original = - Fs_original/2 : deltaF_original : Fs_original/2 - deltaF_original; % frequency vector
stem(fvec_original, fftshift(20*log10(abs(fft_original))), 'BaseValue', -300); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Original Signal (Frequency Domain)');

% Compute the FFT of the upsampled signal
subplot(2, 3, 5);
fft_upsampled = fft(upsampled);
deltaF_target = Fs_target/length(upsampled); % frequency increment
fvec_target = - Fs_target/2 : deltaF_target : Fs_target/2 - deltaF_target; % frequency vector
stem(fvec_target, fftshift(20*log10(abs(fft_upsampled))), 'BaseValue', -300); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Upsampled Signal (Frequency Domain)');

% Plot the FFT of the filtered signal
subplot(2, 3, 6);
% filtered1 = filtered(51:2250);
fft_filtered = fft(filtered);
deltaF_filtered = Fs_target/length(filtered); % frequency increment
fvec_filtered = - Fs_target/2 : deltaF_filtered : Fs_target/2 - deltaF_filtered; % frequency vector
stem(fvec_filtered, fftshift(20*log10(abs(fft_filtered))), 'BaseValue', -300); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Filtered Signal (Frequency Domain)');

%%
% Original Signal Parameters
Fs = 150;       % Desired sample rate after upsampling
T = 1/Fs;       % Time period
duration = 1;   % Duration of the signal in seconds
f = 10;         % Frequency of the sine wave in Hz

% Upsampling Parameters
upsamplingFactor = 15;

% Time vectors
t_original = 0:T:duration-T;                                 % Time vector for original signal
t_upsampled = 0:(T/upsamplingFactor):(duration-T/upsamplingFactor);  % Time vector for upsampled signal

% Generate the original signal
originalSignal = sin(2*pi*f*t_original);

% Upsample the signal
upsampledSignal = upsample(originalSignal, upsamplingFactor);

% Design the low-pass filter
cutoffFreq = 20;  % Cutoff frequency of the low-pass filter in Hz
normalizedCutoffFreq = cutoffFreq / (Fs/2);  % Normalized cutoff frequency
filterOrder = 50;  % Order of the filter

% Design the filter coefficients
filterCoeffs = fir1(filterOrder, normalizedCutoffFreq);

% Apply the low-pass filter to the upsampled signal
filteredSignal = filtfilt(filterCoeffs, 1, upsampledSignal);

% Plot the filtered signal in time domain
subplot(1, 1, 1);
plot(t_upsampled, filteredSignal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Signal (Time Domain)');

%%
close all;
clear all;

% Upsampling Parameters
upsamfac = 15;

% Original Sampling parameters
Fs_original = 150;
T_original = 1/Fs_original;

% Upsampled sampling parameters
Fs_target = Fs_original * upsamfac;       % Target upsampled sampling frequency
T_target = 1/Fs_target; 

% Signal parameters
duration = 1;   % Duration(seconds)
f = 10;         % Signal frequency

% Set the time vectors 
t_original = 0:T_original:duration-T_original;                       
t_upsampled = 0:(T_original/upsamfac):(duration-T_original/upsamfac); 
t_filtered = 0:(T_original/upsamfac):(duration - T_original/upsamfac);
t_filtered1 = t_filtered(51:2075);

% Generate the original sinewave signal
original = sin(2*pi*f*t_original);

% Upsample the signal
upsampled = upsample(original, upsamfac);

% Design the low-pass filter
cutoffFreq = 75;  % Cutoff frequency of the low-pass filter in Hz
normalizedCutoffFreq = cutoffFreq / (Fs_target/2);  % Normalized cutoff frequency
filterOrder = 100;  % Order of the filter

% Design the filter coefficients
filterCoeffs = fir1(filterOrder, normalizedCutoffFreq);

% Apply the low-pass filter to the upsampled signal
filtered = filter(filterCoeffs, 1, upsampled);
filtered1 = filtered(51:2075);


% Plot the original signal in time domain
subplot(2, 3, 1);
plot(t_original, original);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Signal (Time Domain)');

% Plot the upsampled signal in time domain
subplot(2, 3, 2);
plot(t_upsampled, upsampled);
xlabel('Time (s)');
ylabel('Amplitude');
title('Upsampled Signal (Time Domain)');

% Plot the filtered signal in time domain
% filtered1 = filtered(51:2250);
% fft_filtered = fft(filtered1);

subplot(2, 3, 3);
plot(t_filtered1, filtered1);
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Signal (Time Domain)');

% Compute the FFT of the original signal
subplot(2, 3, 4);
fft_original = fft(original);
deltaF_original = Fs_original/length(original); % frequency increment
fvec_original = - Fs_original/2 : deltaF_original : Fs_original/2 - deltaF_original; % frequency vector
stem(fvec_original, fftshift(20*log10(abs(fft_original))), 'BaseValue', -300); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Original Signal (Frequency Domain)');

% Compute the FFT of the upsampled signal
subplot(2, 3, 5);
fft_upsampled = fft(upsampled);
deltaF_target = Fs_target/length(upsampled); % frequency increment
fvec_target = - Fs_target/2 : deltaF_target : Fs_target/2 - deltaF_target; % frequency vector
stem(fvec_target, fftshift(20*log10(abs(fft_upsampled))), 'BaseValue', -300); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Upsampled Signal (Frequency Domain)');

% Plot the FFT of the filtered signal
subplot(2, 3, 6);
% filtered1 = filtered(51:2250);
fft_filtered = fft(filtered1);
deltaF_filtered = Fs_target/length(filtered1); % frequency increment
fvec_filtered = - Fs_target/2 : deltaF_filtered : Fs_target/2 - deltaF_filtered; % frequency vector
stem(fvec_filtered, fftshift(20*log10(abs(fft_filtered))), 'BaseValue', -300); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Filtered Signal (Fresquency Domain)');








% L_filtered = length(filteredSignal);
% Y_filtered = fft(filteredSignal);
% P2_filtered = abs(Y_filtered/L_filtered);
% P1_filtered = P2_filtered(1:L_filtered/2+1);
% P1_filtered(2:end-1) = 2*P1_filtered(2:end-1);
% f_filtered = Fs*(0:(L_filtered/2))/L_filtered;
% 
% subplot(2, 2, 6);
% plot(f_filtered, P1_filtered);
% xlabel('Frequency (Hz)');
% ylabel('Amplitude');
% title('Filtered Signal (Frequency Domain)');







% L = length(original);
% fft_original = fft(original);
% P2_original = abs(fft_original/L);
% P1_orifft_original = fft(original);ginal = P2_original(1:L/2+1);
% P1_original(2:end-1) = 2*P1_original(2:end-1);
% f_original = Fs*(0:(L/2))/L;

% Plot the FFT of the original signal
% subplot(2, 2, 3);
% plot(f_original, P1_original);
% xlabel('Frequency (Hz)');
% ylabel('Amplitude');
% title('Original Signal (Frequency Domain)');

% Compute the FFT of the upsampled signal
% L_upsampled = length(upsampled);
% Y_upsampled = fft(upsampled);
% P2_upsampled = abs(Y_upsampled/L_upsampled);
% P1_upsampled = P2_upsampled(1:L_upsampled/2+1);
% P1_upsampled(2:end-1) = 2*P1_upsampled(2:end-1);
% f_upsampled = Fs*(0:(L_upsampled/2))/L_upsampled;

% Plot the FFT of the upsampled signal
% subplot(2, 2, 4);
% plot(f_upsampled, P1_upsampled);
% xlabel('Frequency (Hz)');
% ylabel('Amplitude');
% title('Upsampled Signal (Frequency Domain)');


