function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% INPUTS
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
%
% OUTPUTS
% bestH - homography model with the most inliers found during RANSAC
if nargin==3
    nIter = 600;
    tol = 4;
end
n_pts = 4;
maxInliers = -1;
points1 = locs1(matches(:,1),1:2);
points2 = locs2(matches(:,2),1:2);
beastInliers = [];
for i=1:nIter
    % randomly choose n_pts points
    randPoints = randperm(size(matches, 1),n_pts);
    locsPointRand1 = locs1(matches(randPoints,1),1:2);
    locsPointRand2 = locs2(matches(randPoints,2),1:2);
    % compute H and calculate H*P2
    H = computeH(locsPointRand1',locsPointRand2');
    Hp2 = H*[points2';ones(1,size(points2,1))];
    Hp2 = (Hp2./repmat(Hp2(3,:),3,1))';
    inliers = (points1(:,1)-Hp2(:,1)).^2+(points1(:,2)-Hp2(:,2)).^2<tol^2;
    inliers_num = size(find(inliers),1);
    if inliers_num>maxInliers
        maxInliers = inliers_num;
        beastInliers = inliers;
    end
end
p1 = points1(beastInliers, :);
p2 = points2(beastInliers, :);
bestH = computeH(p1', p2');