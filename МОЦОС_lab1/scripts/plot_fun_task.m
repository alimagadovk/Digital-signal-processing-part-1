clear;
close all;

%%%%%%%%%%%%%% Параметры %%%%%%%%%%%%%%%%
% Базис (walsh, rademacher или haar)
basis = 'walsh';
% Максимальный номер функции
total_funs = 12;
% Начало периода
T0 = 0;
% Конец периода
T1 = 1;
% Число точек для вычисления функции
points = 300;
% Задержка показа очередной функции, с
delay = 1.5;
%%%%%%%%%%%%%% Конец параметров %%%%%%%%%%%%%%%%

T = T1 - T0;
plot_time = linspace(T0, T1, points);
h = figure;
set(h, 'DoubleBuffer', 'on');

for i=0:total_funs
    fvalues = feval(basis, plot_time, i);

    plot(plot_time, fvalues, 'r', 'LineWidth', 2.5); grid;
    axis([T0, T1, 1.5*[min(min(fvalues),-1)-0.1,max(max(fvalues),1)+0.1]]);
    title(sprintf('%s-%d of %d', basis, i, total_funs));
    pause(delay);
end
