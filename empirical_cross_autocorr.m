% %%%output :
% total_acs --> covariance vector'
% %input:
% data_y -->y   r-->lags
% data_x -->x
function [total_acs] = empirical_cross_autocorr(data_y,data_x,r)
    r = r+1;
    acs = ones(1,r);
    acs_negative = ones(1,r-1);
    u_x = mean(data_x);
    u_y = mean(data_y);
    data_y = data_y-u_y;
    data_x = data_x-u_x;
   % caculating empirical autocorelation for each invidual data point
   for i = 1:r
       my_sum = 0;
       for k = 1:length(data_y)-i+1    
           my_sum = my_sum + (data_y(k))*(data_x(k+i-1));
       end 
       acs(i) = my_sum/length(data_y);
   end 
   counter = 1;
   %caculate the negative part by shift the y and leave the x stay the same
   for i = 2:r
       my_sum = 0;
       for k = 1:length(data_x)-i+1    
          my_sum = my_sum + (data_x(k))*(data_y(k+i-1));
       end 
       acs_negative(counter) = my_sum/length(data_x);
       counter = counter+1;
   end 
   total_acs = [flip( acs_negative),acs];
end