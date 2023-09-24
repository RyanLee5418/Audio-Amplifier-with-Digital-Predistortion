function [c,d] = amplifier_model_extraction(x, y)
  order = length(x);
  x_in = x(1:order);
  X = zeros(order, 4);
  Y = y;
  % Create the cubic matrix X  
  xc = x.';
  X = [xc.^0, xc.^1, xc.^2, xc.^3];
  d = X;
  c = X\Y.'; % Calculate the coefficients of the model
end