close all
clear all

load ideal_carrier_dpd_data.mat
load coe1.mat
fsig = 1000;
x_t = 2*sin(2*pi*fsig*t);
xc = x_t.';
X = [xc.^0, xc.^1, xc.^2, xc.^3];
ys = X*c;
Y = y.';

