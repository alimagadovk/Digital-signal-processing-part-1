function [a, res] = Filter_synth(bandwidth,suppr_band,M)
bandwidth(2) = bandwidth(2) + 0.015*pi;
suppr_band(1) = suppr_band(1) - 0.015*pi;
st = pi/M;
vw = 0:st:pi;
n = find((mod(vw,2*pi) > bandwidth(2)) & (mod(vw,2*pi) < suppr_band(1)));
k = -1/(suppr_band(1) - bandwidth(2));
b = 1 - bandwidth(2)*k;
y = @(x)k.*x + b;
f = @(tr_proc)Funct(vw,tr_proc(1:length(n)),bandwidth,suppr_band,M);
opt = fminsearch(f,y(vw(n(1):n(end))));
tempK = K3(vw,opt,bandwidth,suppr_band);
for j = 0:M
    Y(j + 1) = tempK(j + 1);
    for k = 0:M
        A(j + 1,k + 1) = cos(vw(j + 1)*k);
    end
end
a = A\Y';
K = @(w)0;
for k = 0:M
    K = @(w)K(w) + a(k + 1) .* cos(w.*k);
end
K = @(w)abs(exp(-1i .* w .* M) .* K(w));
res = K;
end