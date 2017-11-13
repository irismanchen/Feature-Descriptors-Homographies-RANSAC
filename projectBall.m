function projectBall()
    points_3d = dlmread('../data/sphere.txt');
    W = [0.0 18.2 18.2 0.0;0.0 0.0 26.0 26.0;1.0 1.0 1.0 1.0];
    W = W';
    X = [483 1704 2175 67;810 781 2217 2286];
    X = X';
    K = [3043.72 0.0 1196.00;0.0 3043.72 1604.00;0.0 0.0 1.0];
    A = zeros(8,9);
    A(1:2:8, 4:6) = -W;
    A(2:2:8, 1:3) = W;
    A(1:2:8, 7:9) = W.*repmat(X(:,2),1,3);
    A(2:2:8, 7:9) = -W.*repmat(X(:,1),1,3);
    [U,S,V] = svd(A);
    H = V(:, end);
    H = reshape(H,[3,3])';
    [R,t] = compute_extrinsics(K, H);
    % compute delta_z
    o_point = [831,1642,1]';
    o_3d_point = inv(H)*o_point;
    o_3d_point(1) = o_3d_point(1)/o_3d_point(3);
    o_3d_point(2) = o_3d_point(2)/o_3d_point(3);
    o_3d_point(3) = 0;
    [z_min,index] = min(points_3d(3,:));
    delta = o_3d_point - points_3d(:,index);
    points_3d = points_3d+repmat(delta,1,size(points_3d,2));
    points_proj = project_extrinsics(K, points_3d, R, t);
    point_num = size(points_proj, 2);
    img = imread('../data/prince_book.jpg');
    figure(1)
    imshow(img);
    hold on;
    plot(points_proj(1,:),points_proj(2,:),'y.');
end