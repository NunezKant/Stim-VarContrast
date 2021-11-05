sca;
close all;
clear;
[screenNumber,white,black,grey] = PsychInit();
[rwrd_img,Norwrd_img] = UploadImages();
rwrd_img = rwrd_img - grey;
Norwrd_img = Norwrd_img - grey;
%% MQTT Setup
myMQTT=mqtt('tcp://127.0.0.1'); 
LickSub = subscribe(myMQTT,'LickPort/','QoS',0);
MoveSub = subscribe(myMQTT,'sphericalTreadmill/Data','QoS',0); 
MoveMsgCount =  0;
LickMsgCount =  0; 
[trials,trial,alpha,img_len,lwr_trsh,hgh_trsh,distToChange,cntrst_dx,aet] = ExperimentSetup(5,300,200,.05,.2);
fprintf('\nIt will take an average estimated time of %6.2f min to finish this experiment\n',aet);
pause(3);
%% Experiment 
try
    %% Texture making
    PsychImaging('PrepareConfiguration');
    PsychImaging('AddTask', 'General', 'FloatingPoint32BitIfPossible');
    [win, winRect] = PsychImaging('OpenWindow', screenNumber,grey,[1920 0 1920*2-1 900*2-1]);
    % rectsize =[top-left-x top-left-y bottom-right-x bottom-left-y]
    Screen('ColorRange', win, 1, 0);
    imagtex_reward = Screen('MakeTexture', win, img1 , [], [], 1);
    imagtex_non_reward = Screen('MakeTexture', win, img2 , [], [], 1);
    
    %% Random texture selection
   [texture_toshow,reward] = RandomImgSelection(imagtex_reward,imagtex_non_reward);
    %% Experiment init
   [distance,SubjM,Licks] = ExperimentInit(trial,alpha,reward);
    %% Experiment run
    t0 = tic;
    while trial<=trials
    %% Modify Texture    
        Screen('Blendfunction', win, GL_SRC_ALPHA, GL_ONE);
        Screen('DrawTexture', win, texture_toshow, [], [], [], 1, alpha);
        Screen('DrawingFinished', win);
    %% Read movement
        pause(2/1000); 
        [SubjM,MoveMsgCount] = ReadMov(MoveSub,MoveMsgCount);
        combinedSpeed = sum(SubjM(end,1:2).^2)^0.5;
    %% Read licks       
        pause(2/1000);  
        [LickMsgCount, IsLicking] = ReadLick(LickSub, LickMsgCount);
        Licks(end+1,:) = [trial distance alpha reward now];
        % if isLicking == 1 ; scatter(Licks(2),Licks(1)) drawnow; end
        %plot the distance in a trial in which a lick ocurred 
    %% Change contrast (alpha) and show it to screen
        if combinedSpeed > lwr_trsh && combinedSpeed < hgh_trsh % only change contrasts if inside tresholds
           distance = distance + combinedSpeed; %distance accumulation
           steps = distance/distToChange; % distance traveled is enough to change to next contrast step 
           if distance <= (img_len/2)
               % increase contrast
                alpha = min(1, steps*cntrst_dx);               
           elseif distance > (img_len/2) && distance <= img_len
               % decrease contrast 
                % If IsLicking == 1 DeliverReward();  end
                alpha = max(0, 1-abs(1-steps*cntrst_dx));
           elseif distance > img_len
               % new trial startup 
                TrialDuration(trial) = toc(t0); % we can plot trial duration to monitor animal engagement with the task
                %stem(TrialDuration) drawnow;
                distance = 0;
                trial = trial + 1;
                SubjM(end+1,:) = [0 0 0 distance trial now];
                [texture_toshow,reward] = RandomImgSelection(imagtex_reward,imagtex_non_reward);
                WaitSecs(2.5) % 100cm waiting time @ 40cm/s
                t0 = tic;
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