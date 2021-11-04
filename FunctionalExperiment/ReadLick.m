function [LickMsgCount, IsLicking] = ReadLick(LickSub, LickMsgCount)
    IsLicking = 0;
    if LickSub.MessageCount > LickMsgCount
        LickMsgCount = LickMsgCount + 1;
        IsLicking = 1;
    end
end

