clear;
close all;

%%%%%%%%%%%%%% Параметры %%%%%%%%%%%%%%%%
% Всего коэффициентов Фурье
total_num = 50;
% Базис (fourier, walsh или haar)
basis = 'haar';
% Начало периода
T0 = 0;
% Конец периода

T1 = 1;
% Число точек для вычисления функции
points = 300;
%%%%%%%%%%%%%% Конец параметров %%%%%%%%%%%%%%%%

T = T1 - T0;
plot_time = linspace(T0, T1, points);
h = figure;
set(h, 'DoubleBuffer', 'on');

K = [-total_num : total_num];

% Здесь нужно вычислить коэффициенты разложения функции fun
% в ряд Фурье.
% C = fseries('fun', ...);
C = fseries('dsp_f2', T0, T1, K, basis); 
fvalues = fun(plot_time);
for i = 3 : 2 : length(K)
    ind = [-floor(i/2) : floor(i/2)] + total_num + 1;
    % Здесь нужно вычислить частичную сумму ряда Фурье.
    % Индексы коэффициентов из вектора C, которые нужно суммировать,
    % содержатся в векторе ind.
    % Если задание выполнено верно, то при нажатии F5 вы увидите, как
    % происходит приближение функции fun частичными суммами ряда Фурье
    % в выбранном базисе
    % S = real(fsum(...));
    S = real(fsum(C(ind), K(ind), T0, T1, plot_time, basis));
    plot(plot_time, fvalues, 'k', plot_time, S, 'r', 'LineWidth', 2); 
    grid;
    axis([T0 T1 min(fvalues)-0.1 max(fvalues)+0.1]);
    title({'Аппроксимация частичными суммами ряда Фурье', basis})
    drawnow;
end 
