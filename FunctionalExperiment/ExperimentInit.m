function [distance,SubjM,Licks] = ExperimentInit(trial,alpha,reward)
distance = 0;
t = now;
SubjM = [0 0 0 distance trial t];
Licks = [trial distance alpha reward t];
end

