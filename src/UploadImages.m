function [rwrd_img,Norwd_img,New_rwrd_img] = UploadImages()
    % [file_r,path_r] = uigetfile('../data/',{'*';'*.png';'*.jpeg'},'Select the rewarded texture');
    % [file_nr,path_nr] = uigetfile('../data/',{'*';'*.png';'*.jpeg'},'Select the NON rewarded texture');
    rwrd_img = imread('./data/leaves.jpg');
    Norwd_img = imread('./data/circles.jpg');
    New_rwrd_img = imread('./data/newleaves.jpg');

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
end

