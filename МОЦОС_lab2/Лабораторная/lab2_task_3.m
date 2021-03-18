% задание 5-6
% Создание входных данных для заданий 5-6
clc
clear
close all

N = 16;
ReX = rand(1,N);
ImX = rand(1,N);
fId = fopen('C:\Users\Курбан\source\repos\ConsoleApplication11\task5_x1.txt', 'wt');
for i = 1:length(ReX)
fprintf(fId,'%10.5f %10.5f\n',ReX(i),ImX(i));
end
fclose(fId);

N = 16;
ReX1 = rand(1,N);
ImX1 = rand(1,N);
fId = fopen('C:\Users\Курбан\source\repos\ConsoleApplication11\task5_x2.txt', 'wt');
for i = 1:length(ReX1)
fprintf(fId,'%10.5f %10.5f\n',ReX1(i),ImX1(i));
end
fclose(fId);

% задание 7
% conv MATLAB
x1 = ReX+1i.*ImX;
x2 = ReX1+1i.*ImX1;
y = conv(x1,x2);
fId = fopen('C:\Users\Курбан\source\repos\ConsoleApplication11\task7_y_ml.txt', 'wt');
for i = 1:length(y)
fprintf(fId,'%10.5f %10.5f\n',real(y(i)),imag(y(i)));
end
fclose(fId);