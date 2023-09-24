% DPD coefficients update funtion
function dpd_n = updated_dpdmodel(c_new, total_coeff_first_order)

c_n = c_new.';

p = zeros(6, 1); % get the same size zero vector

a = total_coeff_first_order / c_n(2); % get n1
b = - ((c_n(3) * a^2) / c_n(2)); % get n2
c = - (2 * a * b * c_n(3) + c_n(4) * a^3) / c_n(2); % get n3
d = - (2 * c_n(3) * a * c + c_n(3) * b^2 + 3 * c_n(4) * a^2 * b)/ c_n(2);
e = - (2 * c_n(3) * a * d + 2 * c_n(3) * b * c + 3 * c_n(4) * a^2 * c + 3 * c_n(4) * a * b^2 )/c_n(2);

p(2) = a;
p(3) = b;
p(4) = c;
p(5) = d;
p(6) = e;

dpd_n = p; % the updated coeffs of DPD
end
