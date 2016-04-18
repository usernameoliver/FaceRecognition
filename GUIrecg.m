global h_axes1
global h_axes2
global edit2
load('recognize.mat');
set(edit2,'string','loading the test dataset...')
drawnow
disp('loading the test dataset...')
disp('.................................................')
img=getimage(h_axes1);%get the information from the image choosen
if isempty(img)
    msgbox('Please find an image first')
    break
end
imglayer1=img(:,:,1);
testface=imglayer1(:)';
set(edit2,'string','decreasing the dimensionality of the data')
drawnow
disp('decreasing the dimensionality of the data')
disp('.................................................')

Z=double(testface)-mA;
pcatestface=Z*V;
set(edit2,'string','normalizing')
drawnow
disp('normalizing')
disp('.................................................')
scaledtestface=-1+(pcatestface-lowvec)./(upvec-lowvec)*2;
set(edit2,'string','SVM sample recognizing......')
drawnow
disp('SVM sample recognizing...')
disp('.................................................')
voting=zeros(1,npersons);
for i=1:npersons-1
    for j=i+1:npersons
        class=svmclassify(multiSVMstruct{i}{j},scaledtestface);
        voting(i)=voting(i)+(class==1);
        voting(j)=voting(j)+(class==0);
    end
end
[~,class]=max(voting);
set(edit2,'string','recognizing finished')
drawnow
axes(h_axes2);
imshow(imread(['D:\04essay\FaceRec\att_faces\s',num2str(class),'\1.jpg']));
msgbox(['This is Person',num2str(class),'.'])