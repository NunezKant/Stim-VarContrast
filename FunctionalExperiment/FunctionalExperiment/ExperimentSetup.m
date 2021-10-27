function [n_trials,trial,alpha,image_length,lower_speed_tresh,higher_speed_tresh,distance_to_change,contrast_dt,AvgElapsedTime] = ExperimentSetup(n_trial,img_length,cntrst_stps,lw_tresh,high_tresh)
n_trials = n_trial;
trial=1;
alpha = 0; %analogous to contrast in this approach 
image_length = img_length; %cm
contrast_changes = cntrst_stps; %number of contrast changes (100 steps from 0 to full contrast and 100 from full to 0)
if (nargin == 3)
    lower_speed_tresh = .05;
    higher_speed_tresh = .2;
else
    lower_speed_tresh = lw_tresh;
    higher_speed_tresh = high_tresh;
end
AvgElapsedTime = (((image_length + (image_length/3))/40)*n_trials)/60; % AET in min (40 cm/s as average speed)
distance_to_change = image_length/contrast_changes;
contrast_dt = 1/(contrast_changes/2);
end

