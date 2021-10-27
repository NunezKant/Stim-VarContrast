function [screenNumber,white,black,grey] = PsychInit(sn)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);
% Get the screen number
screens = Screen('Screens');
if (nargin == 0)
% Draw to the external screen if avaliable
    screenNumber = max(screens);
else
    screenNumber = sn;
end
% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
end

