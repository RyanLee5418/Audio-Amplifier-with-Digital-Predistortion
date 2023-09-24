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
for i = 1: order
    for j = 1: 4
      if j == 1
        X(i, j) = 1;
      elseif j == 2 
        X(i, j) = x_in(i);
      elseif j == 3 
        X(i, j) = x_in(i)*x_in(i);
      else 
        X(i, j) = x_in(i)*x_in(i)*x_in(i);
      end
    end
d = X;
c = X\y.'; % Calculate the coefficients of the model
end
end