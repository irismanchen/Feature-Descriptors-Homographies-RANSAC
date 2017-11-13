function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% Takes in DoGPyramid generated in createDoGPyramid and returns
% PrincipalCurvature,a matrix of the same size where each point contains the
% curvature ratio R for the corre-sponding point in the DoG pyramid
%
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% OUTPUTS
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each 
%                      point contains the curvature ratio R for the 
%                      corresponding point in the DoG pyramid
PrincipalCurvature = zeros(size(DoGPyramid));
t = size(DoGPyramid,3);
for i=1:t
    [Dx, Dy]=gradient(DoGPyramid(:,:,i));
    [Dyx,Dyy]=gradient(Dy);
    [Dxx,Dxy]=gradient(Dx);
    PrincipalCurvature(:,:,i)=(Dxx+Dyy).*(Dxx+Dyy)./(Dxx.*Dyy-Dxy.*Dyx);
end