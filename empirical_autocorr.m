function [total_acs] = empirical_autocorr(data,t)
    t = t+1;
   acs = ones(1,t);
    u = mean(data);
   % caculating empirical autocorelation for each invidual data point
   for i = 1:t
       my_sum = 0;
       for k = 1:length(data)-i+1    
           my_sum = my_sum + (data(k)-u)*(data(k+i-1)-u);
       end 
       acs(i) = my_sum/length(data);
   end 
   % flip the positive covariances (symetrical)
   acs_negative = flip(acs);
   total_acs = [acs_negative(1:end-1),acs(1:end)];
end