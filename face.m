clc,clear
npersons=10;% 40 persons and their face.
global imgrow;
global imgcol;
global edit2
imgrow=112;
imgcol=92;

set(edit2,'string','loading training dataset......')%??????edit2?????
drawnow     %updating window contents
f_matrix=ReadFace(npersons,0);%loading training set
nfaces=size(f_matrix,1);%The number of human face samples

set(edit2,'string','capturing PCA features......')
drawnow
mA=mean(f_matrix);
k=20;%cutting to 20d?
[pcaface,V]=fastPCA(f_matrix,k,mA);%PCA

set(edit2,'string','Normalizing......')
drawnow
lowvec=min(pcaface);
upvec=max(pcaface);
scaledface = scaling( pcaface,lowvec,upvec);

set(edit2,'string','SVM sample training......')
drawnow
gamma=0.0078;
c=128;
multiSVMstruct=multiSVMtrain( scaledface,npersons,gamma,c);
save('recognize.mat','multiSVMstruct','npersons','k','mA','V','lowvec','upvec');

set(edit2,'string','loading test dataset......')
drawnow
[testface,realclass]=ReadFace(npersons,1);

set(edit2,'string','cutting dimensionalities of test data......')
drawnow
m=size(testface,1);
for i=1:m
    testface(i,:)=testface(i,:)-mA;
end
pcatestface=testface*V;

set(edit2,'string','Normalizing......')
drawnow
scaledtestface = scaling( pcatestface,lowvec,upvec);

set(edit2,'string','SVM sample classification......')
drawnow
class= multiSVM(scaledtestface,multiSVMstruct,npersons);
set(edit2,'string','Done')
accuracy=sum(class==realclass)/length(class);
msgbox(['Accuracy',num2str(accuracy*100),'%.'])