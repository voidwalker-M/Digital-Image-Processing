function q = guided_filter(I, p, r, eps)
% function: to implement guided filter
% parameters:
%   I - guidance image
%   p - filtering input image
%   r - local window radius
%   eps - regularization parameter

[h, w] = size(I);
N = boxfilter(ones(h, w), r); % the size of each local patch; N=(2r+1)^2 except for boundary pixels.

mean_I = boxfilter(I, r) ./ N;       % mean filtering for I
mean_p = boxfilter(p, r) ./ N;       % mean filtering for p
mean_Ip = boxfilter(I.*p, r) ./ N;   % mean filter for I*p
cov_Ip = mean_Ip - mean_I .* mean_p; % covariance of (I, p) in each local patch.
mean_II = boxfilter(I.*I, r) ./ N;
var_I = mean_II - mean_I .* mean_I;

a = cov_Ip ./ (var_I + eps);        % Eqn. a = (cov_Ip) / (var_I + eps);
b = mean_p - a .* mean_I;           % Eqn. b = mean_p - a * mean_I

mean_a = boxfilter(a, r) ./ N;
mean_b = boxfilter(b, r) ./ N;

q = mean_a .* I + mean_b;           % Eqn. q = mean_a * I + mean_b
end