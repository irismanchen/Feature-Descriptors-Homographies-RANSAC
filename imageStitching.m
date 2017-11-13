function [panoImg] = imageStitching(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image
    outSize = [576 1894];
    img2_warped = warpH(img2, H2to1, outSize);
    % blend img1 and img2_warped
    for i = 1:size(img1, 1)
        for j = 1:size(img1, 2)
            if img2_warped(i,j,:)<img1(i,j,:)
                img2_warped(i,j,:) = img1(i,j,:);
            end
        end
    end
    panoImg = img2_warped;
    figure(1);
    imshow(panoImg);
end