function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
    target_width = 1894;
    [h2,w2,~] = size(img2);
    [h1,w1,~] = size(img1);
    img2_corner = [1 1 w2 w2;
                   1 h2 1 h2;
                   1 1 1 1];
    img2_corner_warped = H2to1*img2_corner;
    img2_corner_warped = img2_corner_warped./repmat(img2_corner_warped(3,:),3,1);
    min_x = min(1,floor(min(img2_corner_warped(2,:))));
    max_x = max(h1,floor(max(img2_corner_warped(2,:))));
    min_y = min(1,floor(min(img2_corner_warped(1,:))));
    max_y = max(w1,floor(max(img2_corner_warped(1,:))));
    target_height = floor((max_x-min_x)*target_width/(max_y-min_y));
    output_size = [target_height target_width];
    total_height = max_x-min_x;
    total_width = max_y-min_y;
    scale = [target_width/total_width 0 0;0 target_height/total_height 0;0 0 1];
    translation = [1 0 -min_y;0 1 -min_x;0 0 1];
    M = scale*translation;
    % blend img1_warped and img2_warped
    img2_warped = warpH(img2, M*H2to1, output_size);
    img1_warped = warpH(img1, M, output_size);
    for i = 1:size(img1_warped, 1)
        for j = 1:size(img1_warped, 2)
            if img1_warped(i,j,:)<img2_warped(i,j,:)
                img1_warped(i,j,:) = img2_warped(i,j,:);
            end
        end
    end
    panoImg = img1_warped;
    figure(1);
    imshow(panoImg);
end
