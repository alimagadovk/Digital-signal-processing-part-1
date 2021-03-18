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
im = imread('var2.png');
figure
imshow(im)
title('Исходное изображение')
rows = size(im,1);
columns = size(im,2);
im2 = zeros(rows + M,columns + M);
im2(1:rows,1:columns,:) = double(im(:,:,1));
im3 = zeros(rows + M,columns + M);
%%
h = [h zeros(1,columns - length(h) + M)];
for i = 1:rows + M
    y = zeros(1,columns + M);
    for n = 0:columns - 1 + M
        for m = 0:n
            y(n + 1) = y(n + 1) + h(m + 1) .* im2(i,n - m + 1);
        end
    end
    im3(i,:) = y;
end
im2(:,:,:) = im3(:,:);
clear y
for i = 1:columns + M
    y = zeros(1,rows + M);
    for n = 0:rows - 1 + M
        for m = 0:n
            y(n + 1) = y(n + 1) + h(m + 1) .* im2(n - m + 1,i);
        end
    end
    im3(:,i) = y';
end
im2(:,:,:) = im3(:,:);
%%
im2 = uint8(im2(1 + M:rows + M,1 + M:columns + M,:));
figure
imshow(im2);
title('Отфильтрованное изображение')
figure
imshow(im - im2);
title('Разность исходного и отфилтрованного изображений')