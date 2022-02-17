function [RwdImg,NoRwdImg,New_rwrd_img] = ResizeNGreyCentering(RwdImg,NoRwdImg,New_rwrd_img,grey,screenNumber,surrounding,res)
    RwdImg = RwdImg + (grey-mean2(RwdImg)) - grey;
    NoRwdImg = NoRwdImg +(grey-mean2(NoRwdImg)) - grey;
    New_rwrd_img = New_rwrd_img + (grey-mean2(New_rwrd_img)) - grey;
    if surrounding
        RwdImg = imresize(RwdImg, [res(2) res(1)]);
        NoRwdImg = imresize(NoRwdImg, [res(2) res(1)]);
        New_rwrd_img = imresize(New_rwrd_img, [res(2) res(1)]);
    else
        [width, height]=Screen('WindowSize', screenNumber);
        RwdImg = imresize(RwdImg, [height width]);
        NoRwdImg = imresize(NoRwdImg, [height width]);
        New_rwrd_img = imresize(New_rwrd_img, [height width]);
    end
end

