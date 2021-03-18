function res = KD(w)
res = (mod(w,2*pi) >= 0) & (mod(w,2*pi) <= 0.45*pi);
end