function [RwdImg,NoRwdImg] = ResizeNGreyCentering(RwdImg,NoRwdImg,grey,screenNumber,surrounding,res)
    RwdImg = RwdImg + (grey-mean2(RwdImg)) - grey;
    NoRwdImg = NoRwdImg +(grey-mean2(NoRwdImg)) - grey;
    
    if surrounding
        RwdImg = imresize(RwdImg, [res(2) res(1)]);
        NoRwdImg = imresize(NoRwdImg, [res(2) res(1)]);
    else
        [width, height]=Screen('WindowSize', screenNumber);
        RwdImg = imresize(RwdImg, [height width]);
        NoRwdImg = imresize(NoRwdImg, [height width]);
    end
end

