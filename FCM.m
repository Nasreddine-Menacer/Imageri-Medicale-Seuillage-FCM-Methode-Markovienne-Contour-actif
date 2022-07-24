
%Tn - nombre d'itérations
%c - les centres de classes
%--------------------------------------------------------------
%I - Image d'entrée
I = imread('IRMcoupe17-t1.jpg');

%k - nombre de classes requis
k = 3;
Tn = 50;
I=double(I);
[H,W]=size(I);
Icm = zeros(H,W);

IC = [];
for i=1:k
    IC=cat(3,IC,I);
end
%Intialisation aléatoire des centre de classes
cc = randi(256,1,k);
TFcm=0;
while(TFcm<Tn)
    c=[];
    R = [];
    tmp = [];
    P = [];
    D=zeros(H,W,1);
    
  for i=1:k  
    U=repmat(cc(i),H,W);
    c=cat(3,c,U);
  end
  
  for i=1:k
    r=repmat(0.000001,H,W);
    R=cat(3,R,r);
  end
    distance=IC-c;
    distance=distance.*distance+R;
    
    dS=1./distance;
    
    for i=1:k
        D = D + dS(:,:,i);
    end
    
    for i=1:k
        dist(:,:,i)=distance(:,:,i).*D;
        Q1(:,:,i)=1./dist(:,:,i);
    end
    
    for i=1:k
     CI(i)=sum(sum(Q1(:,:,i).*Q1(:,:,i).*I))/sum(sum(Q1(:,:,i).*Q1(:,:,i)));
    end
    
%     image(Q(:,:,1));
    
    for i=1:k
     tmp = cat(3,tmp,abs(cc(i)-CI(i))/cc(i));
    end
    
    for i=1:k
      P = cat(3,P,Q1(:,:,i));
    end
    
    for i=1:H
        for j=1:W
            for l=1:k
                if max(P(i,j,:))==Q1(i,j,l)
                    Icm(i,j)=l;
                end
            end
        end
    end
 %------------------------------------------------------------------
   if max(tmp)<0.0001
         break;
  else
   cc = CI;       % mises à jour des centres des classes
  end
Ifc=uint8(Icm);

TFcm=TFcm+1;

end
u1=zeros(H,W);
u2=zeros(H,W);
u3=zeros(H,W);
for i=1:H
        for j=1:W
            if(Icm(i,j)==1)
                u1(i,j)= 50;
            else if(Icm(i,j)==2)
                    u2(i,j)= 50;
                else
                    u3(i,j)= 50;
                end
            end
        end
end

figure(1);title('les 3 classes obtenues de l IRM de la tumeur')
subplot(1,3,1);
imshow(Q1(:,:,1));
subplot(1,3,2);
imshow(Q1(:,:,2));
subplot(1,3,3);
imshow(Q1(:,:,3));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Image apres  mois %%%%%%%%%%%%%%%%%%%%%%%%%%


I1 = imread('IRMcoupe17-t2.jpg');
k1 = 3;
Tn1 = 50;
I2=double(I1);
[H1,W1]=size(I2);
Icm1 = zeros(H1,W1);
IC1 = [];
for i=1:k1
    IC1=cat(3,IC1,I2);
end
%% initialization aléatoire des centres des classes
cc1 = randi(256,1,k1);
TFcm1=0;
while(TFcm1<Tn1)
    c1=[];
    R1 = [];
    tmp1 = [];
    P1 = [];
    D1=zeros(H1,W1,1);    
  for i=1:k1  
    U1=repmat(cc1(i),H1,W1);
    c1=cat(3,c1,U1);
  end
  for i=1:k1
    r1=repmat(0.000001,H1,W1);
    R1=cat(3,R1,r1);
  end
    distance1=IC1-c1;
    distance1=distance1.*distance1+R1;
    
    dS1=1./distance1;
    
    for i=1:k1
        D1 = D1 + dS1(:,:,i);
    end
    
    for i=1:k1
        dist1(:,:,i)=distance1(:,:,i).*D1;
        Q1(:,:,i)=1./dist1(:,:,i);
    end
    
    for i=1:k1
     CI1(i)=sum(sum(Q1(:,:,i).*Q1(:,:,i).*I2))/sum(sum(Q1(:,:,i).*Q1(:,:,i)));
    end
    for i=1:k1
     tmp1 = cat(3,tmp1,abs(cc1(i)-CI1(i))/cc1(i));
    end
    
    for i=1:k1
      P1 = cat(3,P1,Q1(:,:,i));
    end
    
    for i=1:H1
        for j=1:W1
            for l=1:k1
                if max(P1(i,j,:))==Q1(i,j,l)
                    Icm1(i,j)=l;
                end
            end
        end
    end
 %------------------------------------------------------------------
   if max(tmp1)<0.0001
         break;
  else
   cc1 = CI1;       %mise à jour des centres des classes
   end 
Ifc1=uint8(Icm1);
TFcm1=TFcm1+1;
end
u11=zeros(H1,W1);
u21=zeros(H1,W1);
u31=zeros(H1,W1);
for i=1:H1
        for j=1:W1
            if(Icm1(i,j)==1)
                u11(i,j)= 50;
            else if(Icm1(i,j)==2)
                    u21(i,j)= 50;
                else
                    u31(i,j)= 50;
                end
            end
        end
end
figure(2);title('les 3 classes obtenues de l IRM de la tumeur apres 4 mois ')
subplot(1,3,1);
imshow(Q1(:,:,1));
subplot(1,3,2);
imshow(Q1(:,:,2));
subplot(1,3,3);
imshow(Q1(:,:,3));
img1_bin1 = im2bw(Q1(:,:,1),0.3);
img2_bin1 = im2bw(Q1(:,:,2),0.3);
i11 = bwlabel(img1_bin1);
i21 = bwlabel(img2_bin1);
region11 = regionprops(i11,'basic');
M11 = max([region11.Area]);
T11 = find([region11.Area] == M11);
CC11 = bwconncomp(i11);
CC21 = bwconncomp(i21);
numPixels11 = cellfun(@numel,CC11.PixelIdxList);


A1 = max(numPixels11);
numPixels21 = cellfun(@numel,CC21.PixelIdxList);
A1 = max(numPixels11);
B1 = max(numPixels21);
Taux1=(B1-A1)/B1;


































fprintf('Le taux de changement de la tumeur aprés 4 mois est : \n -5.760874 \n')


