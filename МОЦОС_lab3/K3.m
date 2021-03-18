function res = K3(w,trans_proc,bandwidth,suppr_band)
res = double((mod(w,2*pi) >= bandwidth(1)) & (mod(w,2*pi) <= bandwidth(2)));
n = find((mod(w,2*pi) > bandwidth(2)) & (mod(w,2*pi) < suppr_band(1)));
res(n(1):n(end)) = trans_proc;
end