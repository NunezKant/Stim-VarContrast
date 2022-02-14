function [texture_toshow] = RandomImgSelection(imagtex_reward,imagtex_non_reward,reward)
    if reward==1
        texture_toshow=imagtex_reward;
    else
        texture_toshow=imagtex_non_reward;
    end
end

