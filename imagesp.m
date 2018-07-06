function [ output_args ] = imagesp( image, dim, method, newFigure )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    if nargin<2
        dim=1;
    end

    if nargin<3
        method=1;
    end
    
    if nargin<4
        newFigure=true;
    end
    
    if newFigure
        figure;
    end

    if method==1
        imagesc(squeeze(max(image,[], dim)));
    else
        iamgesc(squeeze(sum(image,dim)));
    end

end

