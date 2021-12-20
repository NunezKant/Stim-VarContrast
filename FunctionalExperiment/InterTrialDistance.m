function [] = InterTrialDistance(win, texture_toshow, MoveSub, MoveMsgCount, distObjective)
    dist = 0; 
    while dist<distObjective
        if MoveSub.MessageCount > MoveMsgCount
            pause(2/1000); 
            MoveMsgCount = MoveMsgCount + 1;
            msg = MoveSub.read;
            m = jsondecode(msg{1});
        end   
        combSpeed = (-m.pitch^2 + m.roll^2)^0.5;
        dist = dist + combSpeed; 
        Screen('DrawTexture', win, texture_toshow, [], [], [], 1, 0);
    end    
end

