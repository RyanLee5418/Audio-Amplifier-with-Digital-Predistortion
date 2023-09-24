close all
clear all

load ideal_carrier_dpd_data.mat
load coefficients.mat % Load the coefficients I got to recreate the model
fsig = 1000;
x_t = 2*sin(2*pi*fsig*t); % Set the input
% Recreate the model 
xc = x_t.';
X = [xc.^0, xc.^1, xc.^2, xc.^3];
ys = X*c; % Get the result by using my coefficients
Y = y.';

f = fft(t);

% Plot the original y and the recreated ys in the same graph 
figure(1)
plot(f,y,"r-","Linewidth",2);
hold on
plot(f,ys,"b-","Linewidth",2); % Recreated

