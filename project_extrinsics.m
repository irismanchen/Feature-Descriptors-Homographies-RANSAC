function [X] = project_extrinsics(K, W, R, t)
    proj_point = K*(R*W+t);
    proj_point = proj_point./repmat(proj_point(3,:),3,1);
    X = proj_point(1:2,:);
end