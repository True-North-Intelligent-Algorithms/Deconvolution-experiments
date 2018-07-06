function [ psf ] = GenerateDiffractionBasedPSF( lambdaEx, lambdaEm, xysize, depth )
%GenerateLasergenPSF Summary of this function goes here
%   Detailed explanation goes here
    if nargin<4
        depth=0
    end

    numAper=0.68;
    magObj=40;
    ccdSize=13000;
    rindexObj=1; % air
    rindexSample=1.33;
    dz=300;
    nslices=1;

    psf = wfmpsf(lambdaEx, lambdaEm, numAper, magObj, rindexObj, ...
        ccdSize, dz, xysize, nslices, rindexSample, depth);

end


