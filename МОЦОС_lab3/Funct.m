function res = Funct(vw,trans_proc,bandwidth,suppr_band,M)
A = zeros(M + 1);
tempK = K3(vw,trans_proc,bandwidth,suppr_band);
for j = 0:M
    Y(j + 1) = tempK(j + 1);
    for k = 0:M
        A(j + 1,k + 1) = cos(vw(j + 1)*k);
    end
end
a = A\Y';
F = @(w)0;
for k = 0:M
    F = @(w)F(w) + a(k + 1) .* cos(w.*k);
end
K = @(w)abs(F(w)) - K3(w,trans_proc,bandwidth,suppr_band);
res = max(abs(K(vw)));
end