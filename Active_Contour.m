I = imread('IRMcoupe17-t1.jpg');  
m = zeros(size(I,1),size(I,2));          
m(120:130,180:190) = 1;
I = imresize(I,.5);  
m = imresize(m,.5);  
figure;
subplot(2,2,1); imshow(I); title('Image IRM');
subplot(2,2,2); imshow(m); title('Masque utilisé');
subplot(2,2,3); title('Image IRM segmentée ');
seg1 = region_seg(I, m, 250); 
subplot(2,2,4); imshow(seg1); title('La tumeur segmentée');


region1 = regionprops(seg1,'basic');
M1 = max([region1.Area]);
T1 = find([region1.Area] == M1);
fprintf('La surface de la tumeur dans la première image est: %d\n',M1)



I = imread('IRMcoupe17-t2.jpg');  
m = zeros(size(I,1),size(I,2));         
m(120:130,180:190) = 1;
I = imresize(I,.5);  
m = imresize(m,.5);  
figure;
subplot(2,2,1); imshow(I); title('Image IRM aprés 4 mois');
subplot(2,2,2); imshow(m); title('Masque utilisé');
subplot(2,2,3); title('Image IRM aprés 4 mois segmentée');
seg = region_seg(I, m, 250); 
subplot(2,2,4); imshow(seg); title('La tumeur aprés 4 mois segmentée');

region1 = regionprops(seg,'basic');
M2 = max([region1.Area]);
T2 = find([region1.Area] == M2);
fprintf('La surface de la tumeur dans la deuxieme image est: %d\n',M2)


Taux = ((M2-M1)/M2)*100;
fprintf('Le taux de changement de la tumeur aprés 4 mois de traitement est : %s\n',Taux)