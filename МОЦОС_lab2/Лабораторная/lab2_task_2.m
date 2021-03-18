% задание 4
% Создание входных данных для задания 4
clc
clear
close all

N = 10;
ReX = rand(1,2^N);
ImX = rand(1,2^N);
fId = fopen('C:\Users\Курбан\source\repos\ConsoleApplication11\task4_x.txt', 'wt');
for i = 1:length(ReX)
fprintf(fId,'%10.5f %10.5f\n',ReX(i),ImX(i));
end
fclose(fId);
%%
% Графики зависимости времени выполнения ДПФ (БПФ) от длины входного
% вектора
fId1 = fopen('C:\Users\Курбан\source\repos\ConsoleApplication11\task4_time_fft.txt', 'rt');
t_fft = fscanf(fId1,'%f',10);
fclose(fId1);
fId2 = fopen('C:\Users\Курбан\source\repos\ConsoleApplication11\task4_time_ft.txt', 'rt');
t_ft = fscanf(fId2,'%f',10);
fclose(fId2);
figure
hold on
grid on
plot(t_fft,'r');
plot(t_ft);
plot(t_fft,'r.');
plot(t_ft, 'b.');
title('Время работы fft и ft');
xlabel('2^n');
ylabel('секунды')
legend('fft','ft');
%%
% Графики зависимости времени выполнения ДПФ (БПФ) от длины входного
% вектора в лог. масштабе
fId1 = fopen('C:\Users\Курбан\source\repos\ConsoleApplication11\task4_time_fft.txt', 'rt');
t_fft = fscanf(fId1,'%f',10);
fclose(fId1);
fId2 = fopen('C:\Users\Курбан\source\repos\ConsoleApplication11\task4_time_ft.txt', 'rt');
t_ft = fscanf(fId2,'%f',10);
fclose(fId2);
figure
hold on
grid on
plot(log(t_fft),'r');
plot(log(t_ft));
plot(log(t_fft),'r.');
plot(log(t_ft), 'b.');
title('Время работы fft и ft в лог. масштабе');
xlabel('2^n');
ylabel('секунды')
legend('fft','ft');