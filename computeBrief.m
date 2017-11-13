function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, ...
                                        levels, compareA, compareB)
%%Compute BRIEF feature
% INPUTS
% im      - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels  - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
%		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of 
%        valid descriptors in the image and will vary
im = im2double(im);
if size(im,3)==3
    im= rgb2gray(im);
end
patchWidth = 9;
nbits = 256;
% remove those keypoints that are on the edge
halfPatchSize = floor(patchWidth / 2);
[m,n,h] = size(GaussianPyramid);
locs = locsDoG((locsDoG(:,1)>halfPatchSize)&(locsDoG(:,1)<n-halfPatchSize)& ...
    (locsDoG(:,2)>halfPatchSize)&(locsDoG(:,2)<m-halfPatchSize), :);
% transform compareA and compareB into 2D relative coordinate
[xx, xy] = ind2sub([patchWidth, patchWidth],compareA);
[yx, yy] = ind2sub([patchWidth, patchWidth],compareB);
% compute the relative coordinate
xx = (xx-halfPatchSize-1)';
xy = (xy-halfPatchSize-1)';
yx = (yx-halfPatchSize-1)';
yy = (yy-halfPatchSize-1)';
numOfLocs = size(locs, 1);
% so this is numofLocs(351) * 256 now
xx = repmat(xx,numOfLocs,1);
xy = repmat(xy,numOfLocs,1);
yx = repmat(yx,numOfLocs,1);
yy = repmat(yy,numOfLocs,1);
locX1 = repmat(locs(:,1), 1, nbits)+xx;
locY1 = repmat(locs(:,2), 1, nbits)+xy;
locX2 = repmat(locs(:,1), 1, nbits)+yx;
locY2 = repmat(locs(:,2), 1, nbits)+yy;
[~,levelIndex] = ismember(locs(:,3),levels);
locLevel = repmat(levelIndex, 1, nbits);
index1 = sub2ind(size(GaussianPyramid),locY1,locX1,locLevel);
index2 = sub2ind(size(GaussianPyramid),locY2,locX2,locLevel);
desc = GaussianPyramid(index1)<GaussianPyramid(index2);
end