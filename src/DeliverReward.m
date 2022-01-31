function [RewardCount] = DeliverReward(myMQTT,RewardCount,ms)
    publish(myMQTT, 'miniBCS/Valve1/Pulse', num2str(ms));
    RewardCount = RewardCount + 1;
end

