lambdaEx=600;
lambdaEm=660;
depth=0;
xysize=15;

h=GenerateDiffractionBasedPSF( lambdaEx, lambdaEm, xysize, depth );
label1=['Diffraction - depth=' num2str(depth)];

x=1:xysize;
y=ceil(xysize/2)*ones(1,xysize);

plot(h(sub2ind(size(h),x,y)));

hold on

depth=2000;
h=GenerateDiffractionBasedPSF( lambdaEx, lambdaEm, xysize, depth );
label2=['Diffraction - depth=' num2str(depth)];

plot(h(sub2ind(size(h),x,y)), 'g');

sigma=0.65;
h = fspecial('gaussian', [15 15], sigma);
plot(h(sub2ind(size(h),x,y)), 'r');
label3=['Gaussiann - sigma=' num2str(sigma)];

sigma=0.8;
h = fspecial('gaussian', [15 15], sigma);
plot(h(sub2ind(size(h),x,y)), 'c');
label4=['Gaussiann - sigma=' num2str(sigma)];

title('PSF - Emission = 660');
axis([1 xysize 0 inf])
legend(label1, label2, label3, label4);



