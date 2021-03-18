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
maxdev = max(abs(y(v) - KD(v)))
w1 = find(v <= 0.4*pi);
w2 = find(v >= 0.5*pi);
if ((max(y(v(w1))) < 1 + dp) && (max(y(v(w1))) > 1 - dp) && (max(y(v(w2))) < ds))
    fprintf('Синтезированный фильтр удовлетворяет требованиям к неравномерности АЧХ')
else
    fprintf('Синтезированный фильтр не удовлетворяет требованиям к неравномерности АЧХ')
end