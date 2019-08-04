[X,Y] = meshgrid(1:100,1:100)
sphere = zeros(100,100)

sphere( ((X-50).^2 + (Y-50).^2)<100 ) = 1;

imagesc(sphere)

kernel1=zeros(21,21);
kernel2=zeros(21,21);

kernel1(11,11)=1;
kernel2(11,11)=1;

kernel1=imgaussfilt(kernel1, 2.0);
kernel2=imgaussfilt(kernel1, 4.0);

figure
imagesc(kernel1)
figure
imagesc(kernel2)

convolved=conv2(sphere, kernel1);

figure
imagesc(convolved)

[deconvolved1, psf1]=deconvblind(convolved, kernel1, 50);

[deconvolved2, psf2]=deconvblind(convolved, kernel2, 50);
[deconvolved3, psf2]=deconvblind(convolved, kernel2, 500);

figure
imagesc(deconvolved1)

figure
imagesc(deconvolved2)
title('50 iterations blind deconvolution, initial guess sigma=4.0');

figure
imagesc(deconvolved3)
title('500 iterations blind deconvolution, initial guess sigma=4.0');




