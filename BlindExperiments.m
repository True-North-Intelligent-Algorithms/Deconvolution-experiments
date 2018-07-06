% prerequisite - Multipage TIFF stack https://www.mathworks.com/matlabcentral/fileexchange/35684-multipage-tiff-stack?focused=7519470&tab=function

img=loadtiff('microtubules.tif');
psf=loadtiff('psfs_microtubules.tif');

figure
imagesc(squeeze(max(img,[],1)));
title('Original Image ZY Max Projection');

figure
imagesc(squeeze(max(psf,[],1)));
title('Original PSF ZY Max Projection');

out_rla_50=deconvlucy(img,psf,50);

options.overwrite=true;

saveastiff(out_rla_50,'out_rla_50.tif', options);

[out_rlab_50, psf_rla_50]=deconvblind(img, psf, 50);

saveastiff(out_rlab_50,'out_rlab_50.tif', options);
saveastiff(single(psf_rla_50),'psf_rla_50.tif', options);

figure
imagesc(squeeze(max(out_rla_50,[],1)));
title('RLA non-blind 50 iterations');

figure
imagesc(squeeze(max(out_rlab_50,[],1)));
title('RLA blind 50 iterations');

figure
imagesc(squeeze(max(psf_rla_50,[],1)));
title('PSF from RLA blind 50 iterations');

fprintf("Sum %f Max %f and Std %f of original PSF\n", sum(psf(:)), max(psf(:)), std(psf(:)));
fprintf("Sum %f Max %f and Std %f of blind PSF\n", sum(psf(:)), max(psf_rla_50(:)), std(psf_rla_50(:)));


