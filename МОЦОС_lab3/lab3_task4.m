clear
close all
clc
M = 23;
[a,~] = Filter_synth([0 0.4*pi],[0.5*pi pi],M);
h = zeros(1,2*M + 1);
h(M + 1) = a(1);
h(M:-1:1) = a(2:M + 1) ./ 2;
h(M + 2:2*M + 1) = h(M:-1:1);
%%
clear y
close all
w = [0.2*pi 0.35*pi];
N = 80;
h = [h zeros(1,N - length(h) + 1)];
for i = 1:2
    y = zeros(1,N+1);
    x = @(n)sin(w(i).*n);
    for n = 0:N
        for m = 0:n
            y(n + 1) = y(n + 1) + h(m + 1) .* x(n - m + 1);
        end
    end
    figure(i)
    hold on
    grid on
    plot(0:N,y,'linewidth',1.75)
    plot(0:N,x(0:N),'r','linewidth',1.75)
    plot(-22:N-22,y,'g-.', 'linewidth',1.5)
    axis([0 80 -2 2])
    title('График исходного и фильтрованного сигналов');
    xlabel('n');
    ylabel('A');
    legend('x(n)', 'y(n)', 'shifted y(n)');
end