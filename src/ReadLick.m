function [Licks,LickMsgCount, IsLicking] = ReadLick(Licks,LickSub,LickMsgCount,trial,distance,alpha,Isrewarded)
    IsLicking = 0;
    if LickSub.MessageCount > LickMsgCount
        LickMsgCount = LickMsgCount + 1;
        IsLicking = 1;
        Licks(end+1,:) = [trial distance alpha Isrewarded now 0];
    end
end

