function [f_matrix,realclass] = ReadFace(npersons,flag)
%Read Images from ORL.
%Input
%     nPersons-The number of persons(first 5 to train&last five to test)
%     imgrow-set row pixels as global var
%     imgcol-set column pixels as global var
%     flag-0 means training while 1 means test
%Output
%imgrow=112; imgcol=92;
global imgrow;
global imgcol;
realclass=zeros(npersons*5,1);
f_matrix=zeros(npersons*5,imgrow*imgcol);
for i=1:npersons
    facepath='D:\04essay\FaceRec\att_faces\s';
    
    facepath=strcat(facepath,num2str(i));
    facepath=strcat(facepath,'\');
    cachepath=facepath;
    for j=1:5
        facepath=cachepath;
        if flag==0 %Reading Training Samples
            facepath=strcat(facepath,'0'+j);
        else %Reading Test Samples
            facepath=strcat(facepath,num2str(5+j));
            realclass((i-1)*5+j)=i;
        end
        facepath=strcat(facepath,'.jpg');
        img=imread(facepath);
        img=img(:,:,1);
        f_matrix((i-1)*5+j,:)=img(:)';
    end
end
end