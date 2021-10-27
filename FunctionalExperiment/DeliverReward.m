function [] = DeliverReward(myMQTT,ms)
    publish(myMQTT, 'miniBCS/Valve1/Pulse', ms);
end

