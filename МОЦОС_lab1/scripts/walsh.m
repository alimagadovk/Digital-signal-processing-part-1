function res = walsh(x, k)
if k < 0
    res = zeros(1, length(x));
    return ;
end
% Walsh function system
% x: vector of argument values
% k: basis function number

res = ones(1, length(x));

bin = dec2bin(k);

for i = 1:length(bin) % от —“ј–Ў≈√ќ бита к младшему
    if bin(i) == '1'
		% вычислите k-ю функцию ”олша
        res = res.*rademacher(x,length(bin)-i);
    end
end