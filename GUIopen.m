global h_axes1
[filename,pathname]=uigetfile({'*.pgm';'*.jpg';'*.tif';'*.*'},'Please choose a photo to recognize.');
if filename==0
    msgbox('Please choose an image file')
else
    filepath=[pathname,filename];
    axes(h_axes1);
    imshow(imread(filepath));
end