clear;
close all;

%%%%%%%%%%%%%% ��������� %%%%%%%%%%%%%%%%
% ����� ������������� �����
total_num = 50;
% ����� (fourier, walsh ��� haar)
basis = 'haar';
% ������ �������
T0 = 0;
% ����� �������

T1 = 1;
% ����� ����� ��� ���������� �������
points = 300;
%%%%%%%%%%%%%% ����� ���������� %%%%%%%%%%%%%%%%

T = T1 - T0;
plot_time = linspace(T0, T1, points);
h = figure;
set(h, 'DoubleBuffer', 'on');

K = [-total_num : total_num];

% ����� ����� ��������� ������������ ���������� ������� fun
% � ��� �����.
% C = fseries('fun', ...);
C = fseries('dsp_f2', T0, T1, K, basis); 
fvalues = fun(plot_time);
for i = 3 : 2 : length(K)
    ind = [-floor(i/2) : floor(i/2)] + total_num + 1;
    % ����� ����� ��������� ��������� ����� ���� �����.
    % ������� ������������� �� ������� C, ������� ����� �����������,
    % ���������� � ������� ind.
    % ���� ������� ��������� �����, �� ��� ������� F5 �� �������, ���
    % ���������� ����������� ������� fun ���������� ������� ���� �����
    % � ��������� ������
    % S = real(fsum(...));
    S = real(fsum(C(ind), K(ind), T0, T1, plot_time, basis));
    plot(plot_time, fvalues, 'k', plot_time, S, 'r', 'LineWidth', 2); 
    grid;
    axis([T0 T1 min(fvalues)-0.1 max(fvalues)+0.1]);
    title({'������������� ���������� ������� ���� �����', basis})
    drawnow;
end 
