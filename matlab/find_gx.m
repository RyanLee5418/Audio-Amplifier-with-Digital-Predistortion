close all
clear all

load ideal_carrier_dpd_data.mat
load coefficients.mat

a_c = [a0, a1, a2, a3];
fsig = 1000;
x = 2*sin(2*pi*fsig*t);
x_v = [ x.^0, x.^1, x.^2, x.^3];
f = c .* x_v;       