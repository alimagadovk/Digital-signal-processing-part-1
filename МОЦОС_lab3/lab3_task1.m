clear
clc
close all
M = 6;
h = zeros(1,M + 1);
for k = 0:M
    for j = 0:M
        h(M - k + 1) = h(M - k + 1) + KD(pi*(j + 0.5)/(M + 1)) * cos(pi*k*(j + 0.5)/(M + 1));
    end
    h(M - k + 1) = h(M - k + 1) / (M + 1);
end
K = @(w)0;
a(1) = h(M + 1);
a(2:M + 1) = 2 .* h(M:-1:1);
for k = 0:M
    K = @(w)K(w) + a(k + 1) .* cos(w.*k);
end
K = @(w)exp(-1i .* w .* M) .* K(w);
w = 0:0.01:2*pi;
plot(w,KD(w));
hold on
grid on
axis ([0 w(end) -2 2])
plot(w,abs(K(w)),'r');
legend('À×Õ KD(w)','À×Õ K(w)');
title('À×Õ');
xlabel('w');
ylabel('|K|');

figure
plot(w,20*log10(double(KD(w))));
hold on
grid on
plot(w,20*log10(abs(K(w))),'r');
legend('À×Õ KD(w)','À×Õ K(w)');
title('À×Õ');
xlabel('w');
ylabel('20log10(|K|)');

figure
plot(w,angle(K(w)));
hold on
grid on
axis ([0 w(end) min(angle(K(w))) max(angle(K(w)))])
title('Ô×Õ');
xlabel('w');
ylabel('arg(K)');
maxdev = max(abs(K(w) - KD(w)))