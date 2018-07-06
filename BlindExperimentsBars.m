% define parameters for PSF with RI mismatch generated at depth=10000 nm
lambdaEx=600;
lambdaEm=660;
numAper=1.3; 
magObj=100; 
rindexObj=1.51;
ccdSize=13000; 
dz=300; 
xysize=64; 
nslices=64; 
rindexSample=1.4; 
depth=10000;

% generate PSF 
psf = wfmpsf(lambdaEx, lambdaEm, numAper, magObj, rindexObj, ...
        ccdSize, dz, xysize, nslices, rindexSample, depth);

% generate PSF at depth = 0 (symmetrical) to use as first guess
psfgirstguess = wfmpsf(lambdaEx, lambdaEm, numAper, magObj, rindexObj, ...
        ccdSize, dz, xysize, nslices, rindexSample, 0);

bars=loadtiff('Bars-Stack.tif');

% uncomment to pad further to completely avoid wrap around
%bars=padarray(bars, [31 31 31]);

% convolve bars image with PSF
otf=single(psf2otf(psf, size(bars)));
barsfft=fftn(bars, size(bars));
temp=otf.*barsfft;
img=ifftn( temp );

% add noise to image
noisy=single(imnoise(uint16(img), 'poisson'));noisy=single(imnoise(uint16(img), 'poisson'));

% perform fixed PSF deconvolution (50 iterations)
fixeddecon50=deconvlucy(noisy, psf, 50);

% perform blind deconvolution (10, 25, and 50 iterations) using unaberrated PSF at first guess
[deconvblind10 blindpsf10]=deconvblind(noisy, psffirstguess, 10);
[deconvblind25 blindpsf25]=deconvblind(noisy, psffirstguess, 25);
[deconvblind50 blindpsf50]=deconvblind(noisy, psffirstguess, 50);

% show figures
figure;
subplot(2,2,1);
imagesp(psf, 1, 1, false);
title('psf');
subplot(2,2,2);
imagesp(psffirstguess, 1, 1, false);
title('psffirstguess');
subplot(2,2,3);
imagesp(blindpsf25, 1, 1, false);
title('blindpsf25');
subplot(2,2,4);
imagesp(blindpsf50, 1, 1, false);
title('blindpsf50');


figure;
subplot(2,2,1);
imagesp(img, 1, 1, false);
title('img');
subplot(2,2,2);
imagesp(deconvblind10, 1, 1, false);
title('deconvblind10');
subplot(2,2,3);
imagesp(deconvblind25, 1, 1, false);
title('deconvblind25');
subplot(2,2,4);
imagesp(deconvblind50, 1, 1, false);
title('deconvblind50');

figure;
subplot(2,2,1);
imagesp(bars, 1, 1, false);
title('bars');
subplot(2,2,2);
imagesp(img, 1, 1, false);
title('img');
subplot(2,2,3);
imagesp(fixeddecon50, 1, 1, false);
title('fixeddecon50');
subplot(2,2,4);
imagesp(deconvblind50, 1, 1, false);
title('deconvblind50');



  
