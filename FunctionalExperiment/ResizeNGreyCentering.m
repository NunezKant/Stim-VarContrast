function [RwdImg,NoRwdImg] = ResizeNGreyCentering(RwdImg,NoRwdImg,grey,screenNumber, surrounding)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    RwdImg = RwdImg + (grey-mean2(RwdImg)) - grey;
    NoRwdImg = NoRwdImg +(grey-mean2(NoRwdImg)) - grey;
    
    if surrounding
        RwdImg = imresize(RwdImg, [1540 2048*3]);
        NoRwdImg = imresize(NoRwdImg, [1540 2048*3]);
    else
        [width, height]=Screen('WindowSize', screenNumber);
        RwdImg = imresize(RwdImg, [height width]);
        NoRwdImg = imresize(NoRwdImg, [height width]);
    end
end

