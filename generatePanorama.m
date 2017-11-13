function generatePanorama(im1, im2)
    [locs1, desc1] = briefLite(im1);
    [locs2, desc2] = briefLite(im2); 
    matches = briefMatch(desc1, desc2);
    % code for 6.2
    %points1 = locs1(matches(:,1),1:2);
    %points2 = locs2(matches(:,2),1:2);
    %H2to1 = computeH(points1',points2');
    %im3_noclip = imageStitching_noClip(im1, im2, H2to1);
    %imwrite(im3_noclip,'../results/q6_2_pan.jpg');
    
    H2to1 = ransacH(matches, locs1, locs2);
    save('../results/q6_1.mat', 'H2to1');
    % code for 6.1
    %im3 = imageStitching(im1, im2, H2to1);
    %imwrite(im3,'../results/q6_1.jpg');
    % code for 6.3
    im3_noclip = imageStitching_noClip(im1, im2, H2to1);
    imwrite(im3_noclip,'../results/q6_3.jpg');
end