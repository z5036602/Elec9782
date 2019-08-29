function [acs,std_err] = my_acs_fun (residual,t)
   acs = ones(1,t);
   sigma_sq = var(residual);
   u = mean(residual);
   std_err = zeros(1,t);
   % caculating empirical autocorelation for each invidual residual point
   for i = 2:t
       my_sum = 0;
       for k = 1:length(residual)-i    
           my_sum = my_sum + (residual(k)-u)*(residual(k+i)-u);
       end 
       acs(i) = my_sum/(length(residual)*sigma_sq);
   end 
   %caculating the standard error using formula on page 7 of slide 4b 
   for i = 2:t
       std_err(i) = sqrt((1+2*sum(acs(2:i).^2))/length(residual));
   end 
end