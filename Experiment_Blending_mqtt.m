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
escape = KbName('ESCAPE');

%% MQTT Setup
myMQTT=mqtt('tcp://127.0.0.1');
LickSub = subscribe(myMQTT,'LickPort/','QoS',0);
MoveSub = subscribe(myMQTT,'sphericalTreadmill/Data','QoS',0); 
MoveMsgCount =  0; % set to 0 after reading MoveMQTT
LickMsgCount =  0; % set to 0 after reading LickMQTT  

%% Experiment setup 
n_trials = 5;
trial=1;
alpha = 0; %analogous to contrast in this approach 
image_length = 300; %cm
contrast_changes = 200; %number of contrast changes (100 steps from 0 to full contrast and 100 from full to 0)
lower_speed_tresh = .05;
higher_speed_tresh = .2;
AvgElapsedTime = ((image_length + (image_length/3))/40)*n_trials; % AET in seconds (40 cm/s as average speed)
%% Experiment 
try
    %% Psych initialization and texture making
    PsychImaging('PrepareConfiguration');
    PsychImaging('AddTask', 'General', 'FloatingPoint32BitIfPossible');
    [win, winRect] = PsychImaging('OpenWindow', screenNumber,grey,[1920 0 1920*2-1 900*2-1]);
    % rectsize =[top-left-x top-left-y bottom-right-x bottom-left-y]
    Screen('ColorRange', win, 1, 0);
    
    
    imagtex_reward = Screen('MakeTexture', win, img1 , [], [], 1);
    imagtex_non_reward = Screen('MakeTexture', win, img2 , [], [], 1);
    
    %% Random texture selection
    reward = randi([0,1]);
    if reward==1
        texture_toshow=imagtex_reward;
    else
        texture_toshow=imagtex_non_reward;
    end
    
    %% Experiment init
    distance_to_change = image_length/contrast_changes;
    contrast_dt = 1/(contrast_change/2);
    distance = 0;
    old_div=0;
    t0 = now;
    SubjM = [0 0 0 distance trial t0];
    Licks = [trial distance alpha reward t0];
    %% Experiment run
    while trial<=n_trials
    %% Change texture        
        Screen('Blendfunction', win, GL_SRC_ALPHA, GL_ONE);
        Screen('DrawTexture', win, texture_toshow, [], [], [], 1, alpha);
        Screen('DrawingFinished', win);
    %% Read movement
        pause(2/1000); 
        
        if MoveSub.MessageCount > MoveMsgCount
            pause(2/1000); 
            MoveMsgCount = MoveMsgCount + 1;
            msg = MoveSub.read;
            m = jsondecode(msg{1});
            SubjM(end+1,:) = [-m.pitch m.roll m.yaw distance trial now];
        end
        combinedSpeed = sum(SubjM(end,1:2).^2)^0.5;
        
%         if (MoveSub.MessageCount - MoveMsgCount) > 1
%             buffer = 0;
%             while MoveSub.MessageCount > MoveMsgCount
%                 buffer = buffer + 1;
%                 pause(2/1000); 
%                 MoveMsgCount = MoveMsgCount + 1;
%                 msg = MoveSub.read;
%                 m = jsondecode(msg{1});
%                 SubjM(end+1,:) = [-m.pitch m.roll m.yaw distance trial now];
%             end
%             combinedSpeed = sum(sum(SubjM(end-buffer:end,1:2).^2,2).^0.5)
%         else
%             MoveMsgCount = MoveMsgCount + 1;
%             msg = MoveSub.read;
%             m = jsondecode(msg{1});
%             SubjM(end+1,:) = [-m.pitch m.roll m.yaw distance trial now];
%             combinedSpeed = sum(SubjM(end,1:2).^2)^0.5;
%         end
        
    %% Read licks       
         pause(2/1000);  
         
        if LickSub.MessageCount > LickMsgCount
            LickMsgCount = LickMsgCount + 1;
            Licks(end+1,:) = [trial distance alpha reward now];
        end
        
    %% Change contrast (alpha) and show it to screen
        if combinedSpeed > lower_speed_tresh && combinedSpeed < higher_speed_tresh % only change contrasts if inside tresholds
           distance = distance + combinedSpeed; %distance accumulation
%            div = floor(distance/distance_to_change); % distance traveled is enough to change to next contrast step 
%            
%            %%%%% Discrete version %%%%%%%%%%
%            if div > old_div && distance <= (image_length/2)
%                % increase contrast if
%                 old_div = old_div + 1;
%                 alpha = min(1, alpha + contrast_dt);               
%            elseif div > old_div && distance > (image_length/2)
%                % decrease contrast if 
%                 old_div = old_div + 1;
%                 alpha = max(0, alpha - contrast_dt);
%            elseif distance > image_length
%                % This if is the new trial startup 
%                 distance = 0;
%                 old_div = 0;
%                 trial = trial + 1;
%                 SubjM(end+1,:) = [0 0 0 distance trial now];
%                 reward = randi([0,1]);
%                 if reward==1
%                     texture_toshow=imagtex_reward;
%                 else
%                     texture_toshow=imagtex_non_reward;
%                 end
%                 WaitSecs(2.5) % 100cm waiting time @ 40cm/s
%            end
%            Screen('Flip', win);
           
           %%%%%%% Continous version %%%%%%%%
           
           div = distance/distance_to_change; % distance traveled is enough to change to next contrast step 
           if distance <= (image_length/2)
               % increase contrast if
                alpha = min(1, div*contrast_dt);               
           elseif distance > (image_length/2)
               % decrease contrast if 
                alpha = max(0, 1-abs(1-div*contrast_dt));
           elseif distance > image_length
               % This if is the new trial startup 
                distance = 0;
                old_div = 0;
                trial = trial + 1;
                SubjM(end+1,:) = [0 0 0 distance trial now];
                reward = randi([0,1]);
                if reward==1
                    texture_toshow=imagtex_reward;
                else
                    texture_toshow=imagtex_non_reward;
                end
                WaitSecs(2.5) % 100cm waiting time @ 40cm/s
           end
           Screen('Flip', win);
        end
    end
    Screen('Flip', win);
    sca;
    return;
catch
    sca;
    psychrethrow(psychlasterror);
end