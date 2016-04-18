clear;
clc;
close all;
Icut = imread('Icut.jpg');
Iresize= imresize(Icut, [112 92])
figure(1),
imshow(Iresize)
imwrite(Iresize,'Iresize.jpg')
