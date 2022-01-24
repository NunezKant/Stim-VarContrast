function [myMQTT,MoveSub,MoveMsgCount,LickSub,LickMsgCount] = MqttSub(mqttip)
    myMQTT=mqtt(mqttip); %add mqqt server selection
    LickSub = subscribe(myMQTT,'LickPort/','QoS',0);
    MoveSub = subscribe(myMQTT,'sphericalTreadmill/Data','QoS',0); 
    MoveMsgCount =  0;
    LickMsgCount =  0; 
end

