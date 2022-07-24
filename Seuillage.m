%% chargement des deux images 
img1 = imread('IRMcoupe17-t1.jpg');
img2 = imread('IRMcoupe17-t2.jpg');

%% affichage des deux images avec leur histogrammes 
figure;
subplot(2,2,1),imshow(img1),title('Image IRM d''un patient')
subplot(2,2,2),imshow(img2),title('Image IRM du même patient aprés 4 mois')
subplot(2,2,3),imhist(img1),title('Histograme de l''image IRM d''un patient')
subplot(2,2,4),imhist(img2),title('Histograme de l''image IRM du même patient aprés 4 mois')


%% Seuillage et labélisation des images
img1_bin = im2bw(img1,0.3);
img2_bin = im2bw(img2,0.3);
i1 = bwlabel(img1_bin);
i2 = bwlabel(img2_bin);

%% Affichage des images seuiller et labéliser
figure;
subplot(1,2,1),imshow(i1),title('Image IRM seuiller d''un patient'),
subplot(1,2,2),imshow(i2),title('Image IRM seuiller du même patient aprés 4 mois')

%% Calcule de la surface de la tumeur de la premiére image
region1 = regionprops(i1,'basic');
M1 = max([region1.Area]);
T1 = find([region1.Area] == M1);
fprintf('La surface de la tumeur dans la première image est: %d\n',M1)

%% Calcule de la surface de la tumeur de l'image aprés 4 mois
region2 = regionprops(i2,'basic');
M2 = max([region2.Area]);
T2 = find([region2.Area] == M2);
fprintf('La surface de la tumeur dans limage après 4 mois est: %d\n',M2)
%% traçage du premier contour
contour1 = (i1==T1);
figure;subplot(1,2,1),imshow(img1),title('Contour de limage IRM seuiller d''un patient'),hold all
contour(contour1);

%% traçage du deuxiéme contour
contour2 = (i2==T2);
subplot(1,2,2),imshow(img1),title('Contour de limage IRM seuiller du même patient aprés 4 mois'),hold all
contour(contour2)

%% Calcule du taux de changement de la tumeur entre les deux périodes
CC1 = bwconncomp(i1);
CC2 = bwconncomp(i2);
numPixels1 = cellfun(@numel,CC1.PixelIdxList);
A = max(numPixels1);
numPixels2 = cellfun(@numel,CC2.PixelIdxList);
A = max(numPixels1);
B = max(numPixels2);
Taux = ((B-A)/B)*100;
fprintf('Le taux de changement de la tumeur aprés 4 mois est : %s\n',Taux)








