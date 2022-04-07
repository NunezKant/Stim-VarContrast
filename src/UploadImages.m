function [rwrd_img,Norwd_img,New_rwrd_img,New_nrwrd_img] = UploadImages(texturecategory)
    % [file_r,path_r] = uigetfile('../data/',{'*';'*.png';'*.jpeg'},'Select the rewarded texture');
    % [file_nr,path_nr] = uigetfile('../data/',{'*';'*.png';'*.jpeg'},'Select the NON rewarded texture');
    switch texturecategory
        case "leavescircles"
        rwrd_img = imread('./data/leaves.jpg');
        Norwd_img = imread('./data/circles.jpg');
        New_rwrd_img = imread('./data/newleaves.jpg');
        New_nrwrd_img = imread('./data/newcircles.jpg');
        case "dryrocks"
        rwrd_img = imread('./data/dryland.jpg');
        Norwd_img = imread('./data/rocks.jpg');
        New_rwrd_img = imread('./data/newdryland.jpg');
        New_nrwrd_img = imread('./data/newrocks.jpg');
        case "mandalasquares"
        rwrd_img = imread('./data/mandala.jpg');
        Norwd_img = imread('./data/squares.jpg');
        New_rwrd_img = imread('./data/newmandala.jpg');
        New_nrwrd_img = imread('./data/newsquares.jpg');   
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

