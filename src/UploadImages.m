function [rwrd_img,Norwd_img,New_rwrd_img,New_nrwrd_img] = UploadImages(texturecategory)
    % [file_r,path_r] = uigetfile('../data/',{'*';'*.png';'*.jpeg'},'Select the rewarded texture');
    % [file_nr,path_nr] = uigetfile('../data/',{'*';'*.png';'*.jpeg'},'Select the NON rewarded texture');
    switch texturecategory
        case "leavescircles"
        rwrd_img = im2double(imread('./data/leaves.jpg'));
        Norwd_img = im2double(imread('./data/circles.jpg'));
        New_rwrd_img = im2double(imread('./data/newleaves.jpg'));
        New_nrwrd_img = im2double(imread('./data/newcircles.jpg'));
        case "circlesleaves"
        rwrd_img = im2double(imread('./data/circles.jpg'));
        Norwd_img = im2double(imread('./data/leaves.jpg'));
        New_rwrd_img = im2double(imread('./data/newcircles.jpg'));
        New_nrwrd_img = im2double(imread('./data/newleaves.jpg'));
        case "tilessquares"
        rwrd_img = im2double(imread('./data/mandala.jpg'));
        Norwd_img = im2double(imread('./data/squares.jpg'));
        New_rwrd_img = im2double(imread('./data/newmandala.jpg'));
        New_nrwrd_img = im2double(imread('./data/newsquares.jpg'));
        case "squarestiles"
        rwrd_img = im2double(imread('./data/squares.jpg'));
        Norwd_img = im2double(imread('./data/mandala.jpg'));
        New_rwrd_img = im2double(imread('./data/newsquares.jpg'));
        New_nrwrd_img = im2double(imread('./data/newmandala.jpg'));
        case "leavestiles"
        rwrd_img = im2double(imread('./data/leaves.jpg'));
        Norwd_img = im2double(imread('./data/mandala.jpg'));
        New_rwrd_img = im2double(imread('./data/newleaves.jpg'));
        New_nrwrd_img = im2double(imread('./data/newmandala.jpg'));
        case "tilesleaves"
        rwrd_img = im2double(imread('./data/mandala.jpg'));
        Norwd_img = im2double(imread('./data/leaves.jpg'));
        New_rwrd_img = im2double(imread('./data/newmandala.jpg'));
        New_nrwrd_img = im2double(imread('./data/newleaves.jpg'));
        case "gray"
        rwrd_img = im2double(imread('./data/gray.jpg'));
        Norwd_img = im2double(imread('./data/gray.jpg'));
        New_rwrd_img = im2double(imread('./data/gray.jpg'));
        New_nrwrd_img = im2double(imread('./data/gray.jpg'));
    end

    if length(size(rwrd_img))>2
        rwrd_img = im2double(rgb2gray(rwrd_img));
    else
        rwrd_img = im2double(rwrd_img);
    end
    if length(size(Norwd_img))>2
        Norwd_img = im2double(rgb2gray(Norwd_img));
    else
        Norwd_img = im2double(Norwd_img);
    end
    if length(size(New_rwrd_img))>2
        New_rwrd_img = im2double(rgb2gray(New_rwrd_img));
    else
        New_rwrd_img = im2double(New_rwrd_img);
    end
    if length(size(New_nrwrd_img))>2
        New_nrwrd_img = im2double(rgb2gray(New_nrwrd_img));
    else
        New_nrwrd_img = im2double(New_nrwrd_img);
    end
end

