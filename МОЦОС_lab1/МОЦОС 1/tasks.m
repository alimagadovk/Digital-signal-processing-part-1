%% part 1
%% task 1
clc
clear
close all
f = @(x)(heaviside(x-0.25) + heaviside(x-0.5) - 2*heaviside(x-0.75));
fseries(f, 0, 1, [0:3], 'haar')
%% part 2
%% task 1
clear
close all
clc
y = @(t) sin(2*pi*t * 20) + sin(2 * pi * t * 40);
t = 0:0.0001:0.1;
vy = y(t);
plot (t,vy,'linewidth',1.5)
hold on
grid on
title('y(t) = sin(2*pi*t * 20) + sin(2 * pi * t * 40)')
xlabel x, ylabel y(t)
%% task 3
F = 200;
dt = 1/(2*F);
vt = 0:dt:0.1;
fk = y(vt);
f = @(x)(sin(2.*pi.*F.*(x - (0:length(vt) - 1).*dt)) ./ (2.*pi.*F.*(x - (0:length(vt) - 1).*dt)));
for i = 1:length(t)
    res(i) = sum(fk.*f(t(i)));
end
plot(t,res, 'r','linewidth',1.5)
F = 400;
dt = 1/(2*F);
vt = 0:dt:0.1;
fk = y(vt);
f = @(x)(sin(2.*pi.*F.*(x - (0:length(vt) - 1).*dt)) ./ (2.*pi.*F.*(x - (0:length(vt) - 1).*dt)));
for i = 1:length(t)
    res(i) = sum(fk.*f(t(i)));
end
plot(t,res, 'g','linewidth',1.5)
F = 1000;
dt = 1/(2*F);
vt = 0:dt:0.1;
fk = y(vt);
f = @(x)(sin(2.*pi.*F.*(x - (0:length(vt) - 1).*dt)) ./ (2.*pi.*F.*(x - (0:length(vt) - 1).*dt)));
for i = 1:length(t)
    res(i) = sum(fk.*f(t(i)));
end
plot(t,res, 'm','linewidth',1.5)
legend('Исходный','Восстановленный fs = 200','Восстановленный fs = 400','Восстановленный fs = 1000');
%%
clear
close all
clc
f = @(t) sin(2*pi*t * 20) + sin(2 * pi * t * 40);
tau = 0.001;
pc = floor(1 / tau) + 1;
t = 0:tau:1;
Y = fft(f(t), pc);
Pyy = abs(Y);
f = 1/tau * (0:1000)/pc;
figure()
plot(f, Pyy(1:1001),'linewidth',1.5)
grid on
title('Спектр сигнала при частоте дискретизации fs = 1000');
%%
clear
f = @(t) sin(2*pi*t * 20) + sin(2 * pi * t * 40);
tau = 0.0025;
pc = floor(1 / tau) + 1;
t = 0:tau:1;
Y = fft(f(t), pc);
Pyy = abs(Y);
f = 1/tau * (0:400)/pc;
figure()
plot(f, Pyy(1:401),'linewidth',1.5)
grid on
title('Спектр сигнала при частоте дискретизации fs = 400');
%%
clear
f = @(t) sin(2*pi*t * 20) + sin(2 * pi * t * 40);
tau = 0.005;
pc = floor(1 / tau) + 1;
t = 0:tau:1;
Y = fft(f(t), pc);
Pyy = abs(Y);
f = 1/tau * (0:200)/pc;
figure()
plot(f, Pyy(1:201),'linewidth',1.5)
grid on
title('Спектр сигнала при частоте дискретизации fs = 200');
%% task 4
clear
close all
clc
y = @(t) sin(2*pi*t * 20) + sin(2 * pi * t * 40);
t = 0:0.0001:0.1;
vy = y(t);
plot (t,vy,'linewidth',1.5)
hold on
grid on
title('y(t) = sin(2*pi*t * 20) + sin(2 * pi * t * 40)')
xlabel x, ylabel y(t)
F = 32;
dt = 1/(2*F);
vt = 0:dt:0.1;
fk = y(vt);
f = @(x)(sin(2.*pi.*F.*(x - (0:length(vt) - 1).*dt)) ./ (2.*pi.*F.*(x - (0:length(vt) - 1).*dt)));
for i = 1:length(t)
    res(i) = sum(fk.*f(t(i)));
end
plot(t,res, 'r','linewidth',1.5)
for k = 0:length(vt) - 1
    res = y(k.*dt);
    plot(k.*dt,res,'b*','linewidth',1.5)
end
legend('Исходный',['Восстановленный fs = ', num2str(F)]);
%%
clear
f = @(t) sin(2*pi*t * 20) + sin(2 * pi * t * 40);
fs = 32;
tau = 1/fs;
pc = floor(1 / tau) + 1;
t = 0:tau:1;
Y = fft(f(t), pc);
Pyy = abs(Y);
f = 1/tau * (0:fs)/pc;
figure()
plot(f, Pyy(1:fs + 1),'linewidth',1.5)
grid on
title(['Спектр сигнала при частоте дискретизации fs = ', num2str(fs)]);
%% task 5
clear
clc
close all
y = @(t) sin(2*pi*t * 20) + sin(2 * pi * t * 40);
sound(y((1:10000)./pi))
pause(4)
sound(y((1:10:100000)./pi))
%% task 6
close all
clear
clc
im = imread('var6.png');
figure()
imshow(im)
title('Исходное изображение')
imsize = size(im);
v = [2 3 4];
for i = 1:3
res = im(mod(1:imsize(1),v(i)) == 0, mod(1:imsize(2),v(i)) == 0);
figure(i + 1)
imshow(res)
title(['Прореживание с уменьш. част. дискр. в ' num2str(v(i)) ' раза'])
end
for i = 1:3
res = imresize(im,1/v(i));
figure(i + 4)
imshow(res)
title(['Уменьшение с помощью imresize в ' num2str(v(i)) ' раза'])
end
%% part 3
%% task 1, 2
close all
clear
f = rand([1,100]);
figure
plot(f)
hold on
grid on
title('f(t)')
xlabel('n')
eps = zeros([1,8]);
SNR = zeros([1,8]);
x = 1:0.01:100;
y = zeros(1,length(x));
for i = 1:8
    figure
    quantf = uquantizer(f,0,1,2^i);
    for j = 1:length(quantf) - 1
        y(1 + (j - 1)*100:100 + (j - 1)*100) = quantf(j);
    end
    plot(x,y,'r')
    eps(i) = sum((quantf-f).^2)/(length(quantf));
    SNR(i) = 20 * log10(sqrt(sum(quantf.^2)/length(quantf)) / sqrt(sum((quantf - f).^2)/length(quantf)));
    grid on;
    title(strcat('бит на отсчет: ',int2str(i)));
    xlabel('n')
    axis([0 100 0 1])
end
%% task 3
figure
plot(eps);
hold on
teps = ((1./(2.^(1:1:8))).^2)./12;
plot(teps)
grid on
title('Ошибка квантования')
legend('Расчётная','Теоретическая')
%% task 4
figure
hold on
plot(SNR);
grid on
title('SNR')
%% task 5, 6
clear
close all
f = normrnd(10,3,[1,50]);
figure
plot(f)
grid on
m = sum(f)/length(f) % 9.363676851881763
sigma = sqrt(sum((f-m).^2)./(length(f)-1)) % 3.267639141797591
%% task 7
[quantf, vt, vd] = LloydMax(f, 0, 1, 4);
t = vt.*sigma + m
d = vd.*sigma + m
%% task 8, 9
x = 1:0.01:50;
y = zeros(1,length(x));
for i = 1:4
quantf = LloydMax(f, m, sigma, i);
for j = 1:length(quantf) - 1
    y(1 + (j - 1)*100:100 + (j - 1)*100) = quantf(j);
end
figure
plot(x,y,'r')
grid on
title(strcat('бит на отсчет: ',int2str(i)));
xlabel('n')
axis([0 50 1 19])
eps(i) = sum((quantf-f).^2)/(length(quantf));
SNR(i) = 20 * log10(sqrt(sum(quantf.^2)/length(quantf)) / sqrt(sum((quantf - f).^2)/length(quantf)));
end
eps
SNR
%% task 10
ueps = zeros([1,4]);
uSNR = zeros([1,4]);
x = 1:0.01:50;
y = zeros(1,length(x));
for i = 1:4
    uquantf = uquantizer(f,min(f) - 0.001,max(f) + 0.001,2^i);
    for j = 1:length(quantf) - 1
    y(1 + (j - 1)*100:100 + (j - 1)*100) = uquantf(j);
    end
    figure
    plot(x,y,'g')
    ueps(i) = sum((uquantf-f).^2)/(length(uquantf));
    uSNR(i) = 20 * log10(sqrt(sum(uquantf.^2)/length(uquantf)) / sqrt(sum((uquantf - f).^2)/length(uquantf)));
    grid on;
    title(strcat('бит на отсчет: ',int2str(i)));
    xlabel('n')
    axis([0 50 1 19])
end
figure
plot(eps);
hold on
plot(ueps)
grid on
title('Ошибка квантования')
legend('Ллойда-Макса','Равномерное')
figure
hold on
plot(SNR);
grid on
plot(uSNR)
title('SNR')
legend('Ллойда-Макса','Равномерное')
%% task 11, 12, 13
close all
clear
im = imread('var6.png');
im = double(im);
for i = [8, 16, 32, 64, 128]
    figure()
    noise = (rand(size(im)) - 0.5) * (256 / i);
    noise_im = uint8(im + noise);
    im1 = uint8(uquantizer2(im, 0, 255, i));
    im2 = uint8(uquantizer2(noise_im, 0, 255, i));
    im3 = uint8(uquantizer2(im, 0, 255, i) + noise);
    subplot(2,2,1)
    imshow(im1)
    title({strcat('Количество уровней яркости: ',int2str(i)),'без шума'})
    subplot(2,2,2)
    imshow(im2)
    title('c шумом до квантования')
    subplot(2,2,4)
    imshow(im3)
    title('c шумом после квантования')
end