function testMatch()
    %path1 = '../data/model_chickenbroth.jpg';
    %path2 = '../data/chickenbroth_01.jpg';
    %path1 = '../data/incline_L.png';
    %path2 = '../data/incline_R.png';
    path1 = '../data/pf_scan_scaled.jpg';
    %path2 = '../data/pf_desk.jpg';
    %path2 = '../data/pf_floor.jpg';
    %path2 = '../data/pf_floor_rot.jpg';
    %path2 = '../data/pf_pile.jpg';
    path2 = '../data/pf_stand.jpg';
    im1 = im2double(imread(path1));
    if size(im1, 3) == 3
        im1 = rgb2gray(im1);
    end
    im2 = im2double(imread(path2));
    if size(im2, 3) == 3
        im2 = rgb2gray(im2);
    end
    [locs1, desc1] = briefLite(im1);
    [locs2, desc2] = briefLite(im2);
    matches = briefMatch(desc1, desc2);
    plotMatches(im1, im2, matches, locs1, locs2);
end