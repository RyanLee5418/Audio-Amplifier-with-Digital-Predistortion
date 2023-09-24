close all;
clear all;

% sine1 = dsp.SineWave(1,10);
% sine1.SamplesPerFrame = 1000;
% N = 1000;
n = 0:0.001:1 - 0.001;
x = sin(2 * pi * 10 * n);
plot(x);
plot(n, x);

% x = x';

% plot(x)

% n=input('Enter length of input sequence:');

l=input('Enter up-sampling factor:');

% m=0:n-1; %making a vector m from the lenght of input sequence
% a=input('Enter Slope of Ramp Signal:');
% x = (0:n-1)*a; % for generating ramp signal x with a slope of a
% %replace your own signal/sequence with the variable x

% figure(1)
% plot(m, x);
% xlabel('Time N');
% ylabel('Amplitude');
% title('Input Signal');

y = zeros(1, l*length(x));
y([1:l:length(y)]) = x;

% nm=0:length(y)-1;
% figure,stem(nm,y); %Upsampled version of signal
% xlabel('Time N');
% ylabel('Amplitude');
% title('Up-Sampled Output of Sign al');
subplot(2, 1, 1);
stem(n, x);
title('Original Signal');
xlabel('Time(Sec)');
ylabel('Amplitude');

subplot(2, 1, 2);
stem(n, y(1:length(x)));
title('Upsampled Signal');
xlabel('Time(Sec)');
ylabel('Amplitude');



X = fft(x);
Ts = 0.1;
fs = 1/Ts;
deltaF = fs/length(x); % frequency increment
fvec = - fs/2 : deltaF : fs/2 - deltaF; % frequency vector
stem(fvec, fftshift(20*log10(abs(X))), 'BaseValue', -300); 
hold on

Y = fft(y);
Ts1 = 1.5;
fs1 = 1/Ts1;
deltaF1 = fs1/length(y); % frequency increment
fvec1 = - fs1/2 : deltaF1 : fs1/2 - deltaF1; % frequency vector
stem(fvec1, fftshift(20*log10(abs(Y))), 'BaseValue', -300); 
hold on



% xi=x;
% yi = interp(xi,l);
% nn=0:length(yi)-1;
% figure,stem(nn,yi); %interpolation output
% xlabel('Time N');
% ylabel('Amplitude');
% title('Interpolator Output');