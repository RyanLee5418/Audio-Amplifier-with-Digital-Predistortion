close all
clear all

[y,Fs] = audioread('upsampled_audio.wav'); % import the .wav file
[y1,Fs1] = audioread('audio01.wav'); % import the .wav file
% sound(y,Fs);
duration = size(y, 1) / Fs;
duration1 = size(y1, 1) / Fs1;

y = y(:, 1); % Original input audio 
y1 = y1(:, 1);

t_original = linspace(0, duration, size(y, 1));
t_non = linspace(0, duration1, size(y1, 1));
% plot(t_original, y, '-.g') % plot the original amplifier audio in red colour 
% hold on
% plot(t_non, y1, '-.r')

% Set the DPD model and Amplifier model
c_new = [0; 8; 1; -0.581; 0; 0]; % set an amplifier model with c2 != 0

c = [0; 8; 1; -0.581]; 

n = [0; 1; -0.125; 0.103875; -0.05515625; 0.04307121875]; % DPD model

total_c1 = 8;

pd_cnew = updated_dpdmodel(c_new, total_c1); % call the DPD update function

% Put the audio into the original amplifier system
% y = y/10; % scale the xin
X = [y.^0, y.^1, y.^2, y.^3, y.^4, y.^5];
X1 = [y1.^0, y1.^1, y1.^2, y1.^3, y1.^4, y1.^5];
yn = X1*c_new; % Only be processed in original amplifier

% Output with pdp and total_c1 is 8
xc_new = X*pd_cnew;
Z_new = [xc_new.^0, xc_new.^1, xc_new.^2, xc_new.^3];
ys_new = Z_new*c; % Be processed in amplifier with DPD


% t_original = linspace(0, duration, size(y, 1));
plot(t_original, y, '-.g') % plot the original amplifier audio in red colour 
hold on
% t_non = linspace(0, duration1, size(y1, 1));
plot(t_non, yn, '-.r')
hold on
plot(t_original, ys_new, '-.b') % plot the DPD system output in green colour
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original Input', 'Without DPD', 'With DPD');
title('Audio Comparison (Time Domain)');



subplot(1, 3, 1);
fft_original = fft(y);
deltaF_original = Fs/length(y); % frequency increment
fvec_original = - Fs/2 : deltaF_original : Fs/2 - deltaF_original; % frequency vector
stem(fvec_original, fftshift(20*log10(abs(fft_original))), 'BaseValue', -25); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Original Iuput(Frequency Domain)');

subplot(1, 3, 2);
fft_DPD = fft(ys_new);
deltaF_DPD = Fs/length(ys_new); % frequency increment
fvec_DPD = - Fs/2 : deltaF_DPD : Fs/2 - deltaF_DPD; % frequency vector
stem(fvec_DPD, fftshift(20*log10(abs(fft_DPD))), 'BaseValue', -25); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('DPD Output(Frequency Domain)');

subplot(1, 3, 3);
fft_non = fft(yn);
deltaF_non = Fs1/length(yn); % frequency increment
fvec_non = - Fs1/2 : deltaF_non : Fs1/2 - deltaF_non; % frequency vector
stem(fvec_non, fftshift(20*log10(abs(fft_non))), 'BaseValue', -25); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Only Amplifier Output(Frequency Domain)');




% Compare the original input audio and output audio of DPD system 
subplot(1, 3, 1);
fft_original = fft(inputAudio);
deltaF_original = originalFs/length(inputAudio); % frequency increment
fvec_original = - originalFs/2 : deltaF_original : originalFs/2 - deltaF_original; % frequency vector
stem(fvec_original, fftshift(20*log10(abs(fft_original))), 'BaseValue', -25); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Original Audio (Frequency Domain)');

subplot(1, 3, 2);
fft_original = fft(inputAudio);
deltaF_original = originalFs/length(inputAudio); % frequency increment
fvec_original = - originalFs/2 : deltaF_original : originalFs/2 - deltaF_original; % frequency vector
stem(fvec_original, fftshift(20*log10(abs(fft_original))), 'BaseValue', -25); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Original Audio (Frequency Domain)');

subplot(1, 3, 3);
fft_original = fft(inputAudio);
deltaF_original = originalFs/length(inputAudio); % frequency increment
fvec_original = - originalFs/2 : deltaF_original : originalFs/2 - deltaF_original; % frequency vector
stem(fvec_original, fftshift(20*log10(abs(fft_original))), 'BaseValue', -25); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Original Audio (Frequency Domain)');



plot(y, '-.r') % plot the original amplifier audio in red colour 
hold on
plot(ys_new, '-.g') % plot the DPD system output in green colour

audiowrite("original_output.wav",yn,Fs); % output the original amplifier audio
audiowrite("DPD_output.wav",ys_new,Fs); % output the DPD system audio
 
Y = fft(ys_new);
deltaF = Fs/length(ys_new); % frequency increment
fvec = - Fs/2 : deltaF : Fs/2 - deltaF; % frequency vector
stem(fvec, fftshift(20*log10(abs(Y))), 'BaseValue', -300); 
hold on

% The fft comparison between the output with dpd and without dpd 
Y_n = fft(yn); % get the fft of output yn(the output signal without dpd)
DF_n = Fs/length(yn); % frequency increment
freqvec_n = -Fs/2 : DF_n : Fs/2 - DF_n; % get the frequency vector
plot(1);
% The fft of output without dpd (with + mark and blue colour)
stem(freqvec_n, fftshift(20*log10(abs(Y_n))), 'BaseValue', -300, 'Marker','+');
hold on
% The fft of output with dpd (without mark and orange colour)
stem(fvec, fftshift(20*log10(abs(Y))), 'BaseValue', -300);


