function [rwrd_img,Norwd_img] = UploadImages()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[file_r,path_r] = uigetfile({'*';'*.png';'*.jpeg'},'Select the rewarded texture');
[file_nr,path_nr] = uigetfile({'*';'*.png';'*.jpeg'},'Select the NON rewarded texture');
rwrd_img = imread(strcat(path_r,file_r));
Norwd_img = imread(strcat(path_nr,file_nr));
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

end

