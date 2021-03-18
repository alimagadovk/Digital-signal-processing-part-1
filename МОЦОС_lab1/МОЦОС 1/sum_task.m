clear;
close all;

total_num = 100; % total Fourier coefficients
basis = 'haar'; % basis (fourier, walsh or haar)
T0 = 0; % srart
T1 = 2; % end
points = 300; % the number of points to calculate the function
T = T1 - T0;
plot_time = linspace(T0, T1, points);
h = figure;
set(h, 'DoubleBuffer', 'on');
K = [-total_num : total_num];

% Here it is necessary to calculate the coefficients of the function fun
% in a Fourier series.
% C = fseries(...);
f = @(t)fun(t);
C = fseries(f, T0, T1, K, basis);

fvalues = fun(plot_time);
for i = 3 : 2 : length(K)
    ind = [-floor(i/2) : floor(i/2)] + total_num + 1;
    
    % S = real(fsum(...));
    S = real(fsum(C(ind), K(ind), T0, T1, plot_time, basis));
    
    plot(plot_time, fvalues, 'k', plot_time, S, 'r', 'LineWidth', 2);
    grid;
    axis([T0 T1 min(fvalues) - 0.1 max(fvalues) + 0.1]);
    title('Approximation of the partial sums of the Fourier series')
    drawnow;
end
