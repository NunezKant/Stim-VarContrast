function [SubjM,MoveMsgCount] = ReadMov(SubjM,MoveSub,MoveMsgCount,distance,trial)
    if MoveSub.MessageCount > MoveMsgCount
        pause(2/1000); 
        MoveMsgCount = MoveMsgCount + 1;
        msg = MoveSub.read;
        m = jsondecode(msg{1});
        SubjM(end+1,:) = [-m.pitch m.roll m.yaw distance trial now];
    end       
%     if (MoveSub.MessageCount - MoveMsgCount) > 1
%         buffer = 0;
%         while MoveSub.MessageCount > MoveMsgCount
%             buffer = buffer + 1;
%             pause(2/1000);
%             MoveMsgCount = MoveMsgCount + 1;
%             msg = MoveSub.read;
%             m = jsondecode(msg{1});
%             SubjM(end+1,:) = [-m.pitch m.roll m.yaw distance trial now];
%         end
%         combinedSpeed = sum(sum(SubjM(end-buffer:end,1:2).^2,2).^0.5);
%     else
%         pause(2/1000);
%         MoveMsgCount = MoveMsgCount + 1;
%         msg = MoveSub.read;
%         m = jsondecode(msg{1});
%         SubjM(end+1,:) = [-m.pitch m.roll m.yaw distance trial now];
%         combinedSpeed = sum(SubjM(end,1:2).^2)^0.5;
%     end
end

