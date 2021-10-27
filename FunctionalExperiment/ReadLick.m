function [Licks, LickMsgCount] = ReadLick(LickSub, LickMsgCount)
    if LickSub.MessageCount > LickMsgCount
        LickMsgCount = LickMsgCount + 1;
        Licks(end+1,:) = [trial distance alpha reward now];
    end
end

