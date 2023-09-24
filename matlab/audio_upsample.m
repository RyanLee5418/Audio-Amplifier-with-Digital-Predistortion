close all;
clear all;

%% Read Audio and Set Parameters
% Load the audio signal
[inputAudio, originalFs] = audioread('audio01.wav');

% Original signal duration
duration = size(inputAudio, 1) / originalFs;

% Upsampling Parameters
upsamplingFactor = 15;

%% Upsample
% Calculate the new sample rate after upsampling
newFs = originalFs * upsamplingFactor;

% Upsample the audio signal
upsampledAudio = upsample(inputAudio, upsamplingFactor);

%% Filtering
% Design the low-pass filter
cutoffFreq = 22500;  % Cutoff frequency of the low-pass filter in Hz
normalizedCutoffFreq = cutoffFreq / (newFs/2);  % Normalized cutoff frequency
filterOrder = 100;  % Order of the filter

% Design the filter coefficients
filterCoeffs = fir1(filterOrder, normalizedCutoffFreq);

% Apply the low-pass filter to the upsampled signal
filteredAudio = filtfilt(filterCoeffs, 1, upsampledAudio);






% Write the upsampled audio signal to a new audio file
audiowrite('upsampled_audio.wav', filteredAudio, newFs);



% Plot the original audio signal in time domain
subplot(2, 3, 1);
t_original = linspace(0, duration, size(inputAudio, 1));
plot(t_original, inputAudio);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Audio (Time Domain)');

% Plot the upsampled audio signal in time domain
subplot(2, 3, 2);
t_upsampled = linspace(0, duration, size(upsampledAudio, 1));
plot(t_upsampled, upsampledAudio);
xlabel('Time (s)');
ylabel('Amplitude');
title('Upsampled Audio (Time Domain)');

subplot(2, 3, 3);
t_filtered = linspace(0, duration, size(filteredAudio, 1));
plot(t_filtered, filteredAudio);
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Audio (Time Domain)');

% Compute the FFT of the original signal
subplot(2, 3, 4);
fft_original = fft(inputAudio);
deltaF_original = originalFs/length(inputAudio); % frequency increment
fvec_original = - originalFs/2 : deltaF_original : originalFs/2 - deltaF_original; % frequency vector
stem(fvec_original, fftshift(20*log10(abs(fft_original))), 'BaseValue', -300); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Original Audio (Frequency Domain)');

% Compute the FFT of the upsampled signal
subplot(2, 3, 5);
fft_upsampled = fft(upsampledAudio);
deltaF_target = newFs/length(upsampledAudio); % frequency increment
fvec_target = - newFs/2 : deltaF_target : newFs/2 - deltaF_target; % frequency vector
stem(fvec_target, fftshift(20*log10(abs(fft_upsampled))), 'BaseValue', -300); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Upsampled Audio (Frequency Domain)');

% Plot the FFT of the filtered signal
subplot(2, 3, 6);
% filtered1 = filtered(51:2250);
fft_filtered = fft(filteredAudio);
deltaF_filtered = newFs/length(filteredAudio); % frequency increment
fvec_filtered = - newFs/2 : deltaF_filtered : newFs/2 - deltaF_filtered; % frequency vector
stem(fvec_filtered, fftshift(20*log10(abs(fft_filtered))), 'BaseValue', -300); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Filtered Audio (Frequency Domain)');
