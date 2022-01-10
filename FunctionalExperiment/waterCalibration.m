function waterCalibration(duration,manual)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
InitializeMatlabOpenGL(1);
myMQTT = mqtt('tcp://169.254.0.10');
pause on
openCount = 0;
givewater = 0;
while 1
   pause(0.2);  
   [KeyIsDown, ~, keyCode] = KbCheck; 
    if KeyIsDown
        knms = KbName(keyCode);
        if sum(strcmp(knms, 'esc'))
            break;
        end  
        if sum(strcmp(knms, 'w'))
            givewater = 1;
        end          
    end
    if manual
        if givewater
            publish(myMQTT, 'miniBCS/Valve1/Pulse', num2str(duration));
            givewater = 0;
            openCount = openCount + 1; 
        end
    else
        openCount = openCount + 1; 
        publish(myMQTT, 'miniBCS/Valve1/Pulse', num2str(duration));
%         pause(5+rand(1)*3);
        pause(0.3);
    end
end
    disp(['Open duration = ' num2str(duration) ' ms']);
    disp(['Open times = ' num2str(openCount)]);
    sca
end

