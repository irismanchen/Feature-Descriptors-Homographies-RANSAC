function H2to1 = computeH(p1,p2)
% INPUTS:
% p1 and p2 - Each are size (2 x N) matrices of corresponding (x, y)'  
%             coordinates between two images
%
% OUTPUTS:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear 
%         equation
    N = size(p1, 2);
    p1 = [p1;ones(1, N)];
    p2 = [p2;ones(1, N)];
    p1 = p1';
    p2 = p2';
    A = zeros(2*N,9);
    A(1:2:2*N, 1:3) = p2;
    A(2:2:2*N, 4:6) = p2;
    A(1:2:2*N, 7:9) = -p2.*repmat(p1(:,1),1,3);
    A(2:2:2*N, 7:9) = -p2.*repmat(p1(:,2),1,3);
    [U,S,V] = svd(A);
    h = V(:, end);
    square_sum = sum(h.^2);
    h = h/square_sum;
    H2to1 = reshape(h,[3,3])';
end
