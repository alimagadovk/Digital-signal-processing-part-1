% задание 8
clc
clear
close all


n = 10;
ReX = rand(1,2^n);
ImX = rand(1,2^n);
fId = fopen('C:\Users\Курбан\source\repos\ConsoleApplication11\task8_x1.txt', 'wt');
for i = 1:length(ReX)
fprintf(fId,'%10.5f %10.5f\n',ReX(i),ImX(i));
end
fclose(fId);


ReX = rand(1,2^n);
ImX = rand(1,2^n);
fId = fopen('C:\Users\Курбан\source\repos\ConsoleApplication11\task8_x2.txt', 'wt');
for i = 1:length(ReX)
fprintf(fId,'%10.5f %10.5f\n',ReX(i),ImX(i));
end
fclose(fId);
%%
close all
fId1 = fopen('C:\Users\Курбан\source\repos\ConsoleApplication11\task8_time_conv_fft.txt', 'rt');
t_fft1 = fscanf(fId1,'%f',10);
t_fft2 = fscanf(fId1,'%f',10);
t_fft3 = fscanf(fId1,'%f',5);
fclose(fId1);
fId2 = fopen('C:\Users\Курбан\source\repos\ConsoleApplication11\task8_time_conv.txt', 'rt');
t_ft1 = fscanf(fId2,'%f',10);
t_ft2 = fscanf(fId2,'%f',10);
t_ft3 = fscanf(fId2,'%f',5);
fclose(fId2);

figure
hold on
grid on 
plot(t_fft1,'r');
plot(t_ft1);
plot(t_fft1,'r.');
plot(t_ft1, 'b.');
title('Сверт. с БПФ и обычн., вект. одинак. длин.');
xlabel('2^n');
ylabel('секунды');
legend('conv fft','conv');

figure
hold on
grid on
plot(t_fft2,'r');
plot(t_ft2);
plot(t_fft2,'r.');
plot(t_ft2, 'b.');
title('Сверт. с БПФ и обычн., один из вект. фикс. длины');
xlabel('2^n');
ylabel('секунды');
legend('conv fft','conv');

figure
hold on
grid on
plot(t_fft3,'r');
plot(t_ft3);
plot(t_fft3,'r.');
plot(t_ft3, 'b.');
title('Сверт. с БПФ и обычн., вект. разн. длин.');
xlabel('2^n');
ylabel('секунды');
legend('conv fft','conv');