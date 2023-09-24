close all
clear all

load ideal_carrier_dpd_data.mat
plot(x, y); title('Data'); % Plot the data  
% Input x and y data, return the coefficients c and the cubic matrix d
[c,d] = modelcoeffs(x, y);  

% % Function for Extract the coefficients of the model
function [c,d] = modelcoeffs(x, y)
  order = length(x);
  x_in = x(1:order);
  X = zeros(order, 4);
  Y = y;
  % Create the cubic matrix X  
  xc = x.';
  X = [xc.^0, xc.^1, xc.^2, xc.^3];
  d = X;
  c = X\y.'; % Calculate the coefficients of the model
end
