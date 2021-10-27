function [texture_toshow,reward] = RandomImgSelection(imagtex_reward,imagtex_non_reward)
reward = randi([0,1]);
if reward==1
    texture_toshow=imagtex_reward;
else
    texture_toshow=imagtex_non_reward;
end
end

