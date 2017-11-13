function [R,t] = compute_extrinsics(K, H)
    H = inv(K)*H;
    [U,S,V] = svd(H(:,1:2));
    t = [1 0;
         0 1;
         0 0];
    R = zeros(3,3);
    R(:,1:2) = U*t*V';
    R(:,3) = cross(R(:,1),R(:,2));
    if det(R)==-1
        R(:,3) = -1*R(:,3);
    end
    p = H(:,1:2)./R(:,1:2);
    lambda = sum(p(:))*1.0/6;
    t = H(:,3)/lambda;
end