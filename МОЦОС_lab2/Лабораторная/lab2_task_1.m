% задание 3 в
% Создание входных данных для заданий 1-3
clc;
clear
close all
n = 4;
ReX = rand(1,2^n);
ImX = rand(1,2^n);
fId = fopen('C:\Users\Курбан\source\repos\ConsoleApplication11\task3_x.txt', 'wt');
for i = 1:length(ReX)
fprintf(fId,'%10.5f %10.5f\n',ReX(i),ImX(i));
end
fclose(fId);
%%
% FFT
x = ReX+1i.*ImX;
y = fft(x)./sqrt(2^n);
fId = fopen('C:\Users\Курбан\source\repos\ConsoleApplication11\task3_y_ml.txt', 'wt');
for i = 1:length(y)
fprintf(fId,'%10.5f %10.5f\n',real(y(i)),imag(y(i)));
end
fclose(fId);