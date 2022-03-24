function [texture_toshow] = RandomImgSelection(imagtex_reward,imagtex_non_reward,imagtex_new_reward,imagtex_new_nreward,rewarded,new_exemplar)
    if rewarded && new_exemplar
        texture_toshow=imagtex_new_reward;
    elseif ~rewarded && new_exemplar
        texture_toshow=imagtex_new_nreward;
    elseif rewarded 
        texture_toshow=imagtex_reward;
    else 
        texture_toshow=imagtex_non_reward;
    end
end

