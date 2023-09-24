load coefficients.mat
load ideal_carrier_dpd_data.mat

%t = 0:0.125:0.875;
fsig = 1;
% x = sin(2*pi*fsig*t);
% plot(t,y,'o');

X = [xc.^0, xc.^1, xc.^2, xc.^3];
xc = 
Z = [xc.^0, xc.^1, xc.^2, xc.^3];
ys = X*c


X = fft(x);
stem(abs(X));
fmax = 1/0.125;

fvec = - length(X)/2 : 1 : length(X)/2 - 1;

stem(fvec, fftshift(20*log10(abs(X))), 'BaseValue', -300);
