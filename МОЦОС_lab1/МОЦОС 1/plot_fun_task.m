clear;
close all;

% basis (walsh, rademacher, haar)
basis = 'haar';
% total coefficient number
total_funs = 12;
% start
T0 = 0;
% end
T1 = 1;
% the number of points to calculate the function
points = 300;
delay = 1.5;

T = T1 - T0;
plot_time = linspace(T0, T1, points);
h = figure;
set(h, 'DoubleBuffer', 'on');

for i=0:total_funs
    fvalues = feval(basis, plot_time, i);

    plot(plot_time, fvalues, 'r', 'LineWidth', 2.5); grid;
    axis([T0, T1, 1.5 * [min(min(fvalues), -1) - 0.1, max(max(fvalues), 1) + 0.1]]);
    title(sprintf('%s-%d of %d', basis, i, total_funs));
    pause(delay);
end
