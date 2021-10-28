function [Licks, LickMsgCount, IsLicking] = ReadLick(LickSub, LickMsgCount)
    IsLicking = 0;
    if LickSub.MessageCount > LickMsgCount
        LickMsgCount = LickMsgCount + 1;
        Licks(end+1,:) = [trial distance alpha reward now];
        IsLicking = 1;
    end
end

