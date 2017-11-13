% Script to test BRIEF under rotations
function briedRotTest()
    path1 = '../data/model_chickenbroth.jpg';
    im1 = im2double(imread(path1));
    if size(im1, 3) == 3
        im1 = rgb2gray(im1);
    end
    [locs1, desc1] = briefLite(im1);
    degreeIncrements = 0:10:359;
    matchNum = zeros(1, length(degreeIncrements));
    for i = 1:length(degreeIncrements)
        imrot = imrotate(im1, degreeIncrements(i));
        [locs2, desc2] = briefLite(imrot);
        matchNum(i) = size(briefMatch(desc1, desc2),1);
    end
    bar(degreeIncrements,matchNum);
    xlabel('rotation angle');
    ylabel('number of correct matches');
end