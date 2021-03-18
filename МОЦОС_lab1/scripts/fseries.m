function c = fseries(target_fun, T0, T1, K, basis)
% Evaluation of Fourier series coefficients.
% Usage:
%   c = fseries(target_fun, T0, T1, K, basis)
%   target_fun - target function 
%   basis - 'fourier' (default), 'walsh', 'rademacher'
%   T0, T1 - start & end of function period 
%   K - coefficient to find (vectorizable)
%   c - vector of Fourier coefficients
% 
% Example:
%   >> c = fseries('sin', 0, 1, [0:3], 'walsh')
%   c =
%      0.4597   -0.2149   -0.1057   -0.0148

if (nargin < 5)
    basis = 'fourier';
end

switch lower(basis)
    case 'fourier'
        f_int = inline([target_fun, '(t) .* exp(-i * 2 * pi * k * t / (T1-T0))'], 't', 'k', 'T0','T1');
        fromZero = 0;
    case {'rademacher', 'walsh'}
        f_int = inline([target_fun, '(t) .* ', basis, '((t - T0)/(T1-T0), k)'], 't', 'k', 'T0','T1');
        fromZero = 1;
    case {'haar'}
        c = haar_coef(target_fun, K, T0, T1);
        return;
end

i = 1;
for k = K
     if (fromZero && k < 0)
         c(i) = 0;
     else
         c(i) = 1 / (T1 - T0) * quadl(@(t) f_int(t, k, T0, T1), T0, T1);
     end
     i = i + 1;
end
