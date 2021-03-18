clear
clc
close all
dp = 0.0275;
ds = 0.02;
M = 23;
[~,y] = Filter_synth([0 0.4*pi],[0.5*pi pi],M);
v = 0:0.001:pi;
figure
plot(v,y(v),'r')
hold on
grid on
title('Фильтр с наилучшим равн. приближением');
xlabel('w');
ylabel('|K|');
plot(v,KD(v));
line([0 0.4*pi], [1+dp 1+dp], 'Color', 'm')
line([0 0.4*pi], [1-dp 1-dp], 'Color', 'm')
line([0.5*pi pi], [ds ds], 'Color', 'm')
%line([0.5*pi pi], [-ds -ds], 'Color', 'm')
legend('АЧХ K(w)');

figure
plot(v,20*log10(y(v)),'r')
hold on
grid on
title('Фильтр с наилучшим равн. приближением');
xlabel('w');
ylabel('20log10(|K(w)|)');
plot(v,20*log10(double(KD(v))));
legend('20log10(|K(w)|)');

maxdev = max(abs(y(v) - KD(v)))