function [] = InterTrialDistance(MoveSub, MoveMsgCount, ImagelengthEditField, Intertrialdistancelabel, low_t, high_t)
    dist = 0;
    while dist<round(ImagelengthEditField.Value/3)
        Intertrialdistancelabel.Text = num2str(dist,4);
        pause(2/1000);
        if MoveSub.MessageCount > MoveMsgCount
            MoveMsgCount = MoveMsgCount + 1;
            msg = MoveSub.read;
            m = jsondecode(msg{1});
            combSpeed = (m.pitch^2 + m.roll^2)^0.5;
        end
        
        if combSpeed > low_t && combSpeed < high_t
            dist = dist + combSpeed;
        end
    end
end

