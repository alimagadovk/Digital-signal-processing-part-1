function res = walsh(x, k)
% Walsh function system
% x: vector of argument values
% k: basis function number

if k < 0
    res = zeros(1, length(x));
    return ;
end

res = ones(1, length(x));

bin = dec2bin(k);


for i = 1:length(bin) 
    if bin(i) == '1'
       %%%%%%
       res = res .* rademacher(x,length(bin) - i);
    end
end
