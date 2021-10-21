%% BASIC SETUP
sca;
close all;
clear;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);
% Get the screen number
screens = Screen('Screens');
% Draw to the external screen if avaliable
screenNumber = max(screens);
% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
%% Loading images

img1 = imread('img1.jpg');
img2 = imread('img2.jpg');
img1 = im2double(rgb2gray(img1));
img2 = im2double(rgb2gray(img2));
img1 = img1 - grey;
img2 = img2 - grey;
%% Keys
KbName('UnifyKeyNames');
leftArrow = KbName('LeftArrow');
rightArrow = KbName('RightArrow');
upArrow = KbName('UpArrow');
escape = KbName('ESCAPE');

%% Experiment 
try
    PsychImaging('PrepareConfiguration');
    PsychImaging('AddTask', 'General', 'FloatingPoint32BitIfPossible');
    [win, winRect] = PsychImaging('OpenWindow', screenNumber,grey,[1920 0 1920*2-1 900*2-1]);
    % rectsize =[top-left-x top-left-y bottom-right-x bottom-left-y]
    Screen('ColorRange', win, 1, 0);
    i=0;
    tonset = [];
    steps = 1;
    n_trials = 5;
    trial=0;
    alpha = 0; %analogous to contrast in this approach 
    
    while trial<=n_trials
        i=i+1;
        if i == 1
            % makes the two textures and selects randomly one
            imagtex_reward = Screen('MakeTexture', win, img1 , [], [], 1);
            imagtex_non_reward = Screen('MakeTexture', win, img2 , [], [], 1);
            r = randi([0,1]);
            if r==1
                texture_toshow=imagtex_reward;
            else
                texture_toshow=imagtex_non_reward;
            end
        end

        
        Screen('Blendfunction', win, GL_SRC_ALPHA, GL_ONE);
        Screen('DrawTexture', win, texture_toshow, [], [], [], 1, alpha);
        Screen('DrawingFinished', win);
                 
        % Keyboard queries:
        [isdown secs keycode] = KbCheck;
        if isdown
            if keycode(escape)
                break;
            end

            if keycode(rightArrow)
                steps = steps + 1 ;
               
                if (steps == 200)
                    steps = 1;
                    trial = trial + 1;
                    r = randi([0,1]);
                    if r==1
                        texture_toshow=imagtex_reward;
                    else
                        texture_toshow=imagtex_non_reward;
                    end
                    WaitSecs(2) % specify the waiting time
                end
                    
                if steps<100
                    alpha = min(1, alpha + 0.01);
                    %imageArray(steps)=mean2(im2double(Screen('GetImage', win,[],[],[],1)));
                end
                if (steps >= 100 && steps <=199)
                    alpha = max(0, alpha - 0.01);
                end   
            end

        end

        % Ready. Request stimulus onset:
        tonset(i) = Screen('Flip', win);

        % Ready. Next loop iteration:
    end

    % One final flip:
    Screen('Flip', win);

    sca;
    
    % Compute avg. computation time for redraw:
    avgredrawtime = mean(diff(tonset)) * 1000;
    %plot(diff(tonset));
    
    % Done.
    return;


%     Screen('CloseAll')
catch
    sca;
    psychrethrow(psychlasterror);
end