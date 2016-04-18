clear all
clc
close all
%Detect objects using Viola-Jones Algorithm
cd('D:/04essay/FaceDetection/physics/1120112925')
%To detect Face
FDetect = vision.CascadeObjectDetector;

%Read the input image
id=8;
cd('D:/04essay/FaceDetection/physics/1120112925')
imagename=cell(1,1);
imagename=[num2str(id) '.jpg'];
I = imread(imagename);

%Returns Bounding Box values based on number of objects
BB = step(FDetect,I);
figure,
imshow(I); hold on
text_str = cell(size(BB,1),1);
text_color=cell(size(BB,1),1);
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',10,'LineStyle','-','EdgeColor','r');
    hold on;
    text_str{i} = [num2str(i)];
    text_color{i} = ['green'];
end
RGB = insertText(I,BB(:,1:2),text_str,'FontSize',36,'BoxColor',text_color,'BoxOpacity',0.05);

imshow(RGB);
hold on;
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
    hold on;
end
title('Face Detection');
hold off;

prompt = 'What is the face id? ';
faceid = input(prompt);

x=BB(faceid,1);%upper left corner and size 
y=BB(faceid,2);
width=BB(faceid,3);
height=BB(faceid,4);
Icut=I([(y):(y+height)],[x:(x+width)],:);
X=imresize(Icut,[112 92]);

cd('D:\04essay\FaceRec\att_faces\s3')
imwrite(X,[num2str(id),'.jpg'])

