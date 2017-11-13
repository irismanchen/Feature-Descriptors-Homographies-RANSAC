function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, ...
                        PrincipalCurvature, th_contrast, th_r)
%%Detecting Extrema
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels  - The levels of the pyramid where the blur at each level is
%               outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the
%                      curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a
%               DoG response magnitude above this threshold
% th_r        - remove any edge-like points that have too large a principal
%               curvature ratio
%
% OUTPUTS
% locsDoG - N x 3 matrix where the DoG pyramid achieves a local extrema in both
%           scale and space, and also satisfies the two thresholds.
	locsDoG = [];
	mask=zeros(3,3,3);
	mask(:,:,1) = [0 0 0;0 1 0;0 0 0];
	mask(:,:,2) = [1 1 1;1 1 1;1 1 1];
	mask(:,:,3) = [0 0 0;0 1 0;0 0 0];
	point = (imdilate(DoGPyramid,mask)==DoGPyramid)|(imerode(DoGPyramid,mask)==DoGPyramid);
	point = point&(abs(DoGPyramid)>th_contrast)&(abs(PrincipalCurvature)<th_r);
	[x,y,z] = ind2sub(size(point),find(point));
	locsDoG = cat(2,y,x,DoGLevels(z)');
end