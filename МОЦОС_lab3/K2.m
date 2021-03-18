function res = K2(w,a,b)
res = (mod(w,2*pi) >= a) & (mod(w,2*pi) <= b);
end