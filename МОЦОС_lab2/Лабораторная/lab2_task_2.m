% ������� 4
% �������� ������� ������ ��� ������� 4
clc
clear
close all

N = 10;
ReX = rand(1,2^N);
ImX = rand(1,2^N);
fId = fopen('C:\Users\������\source\repos\ConsoleApplication11\task4_x.txt', 'wt');
for i = 1:length(ReX)
fprintf(fId,'%10.5f %10.5f\n',ReX(i),ImX(i));
end
fclose(fId);
%%
% ������� ����������� ������� ���������� ��� (���) �� ����� ��������
% �������
fId1 = fopen('C:\Users\������\source\repos\ConsoleApplication11\task4_time_fft.txt', 'rt');
t_fft = fscanf(fId1,'%f',10);
fclose(fId1);
fId2 = fopen('C:\Users\������\source\repos\ConsoleApplication11\task4_time_ft.txt', 'rt');
t_ft = fscanf(fId2,'%f',10);
fclose(fId2);
figure
hold on
grid on
plot(t_fft,'r');
plot(t_ft);
plot(t_fft,'r.');
plot(t_ft, 'b.');
title('����� ������ fft � ft');
xlabel('2^n');
ylabel('�������')
legend('fft','ft');
%%
% ������� ����������� ������� ���������� ��� (���) �� ����� ��������
% ������� � ���. ��������
fId1 = fopen('C:\Users\������\source\repos\ConsoleApplication11\task4_time_fft.txt', 'rt');
t_fft = fscanf(fId1,'%f',10);
fclose(fId1);
fId2 = fopen('C:\Users\������\source\repos\ConsoleApplication11\task4_time_ft.txt', 'rt');
t_ft = fscanf(fId2,'%f',10);
fclose(fId2);
figure
hold on
grid on
plot(log(t_fft),'r');
plot(log(t_ft));
plot(log(t_fft),'r.');
plot(log(t_ft), 'b.');
title('����� ������ fft � ft � ���. ��������');
xlabel('2^n');
ylabel('�������')
legend('fft','ft');