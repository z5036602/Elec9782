%%%simulate the data first
T = 100;                                         
p1 = 0.9;                                          
p2 = 0.7;
p3 = 0.5;
[rho1,rho2,rho3,~,output] = ar3_sim(p1,p2,p3);  
%%%define the upper bound of the system's order and perform BIC
total_order = 15;
BIC = zeros(1,total_order);
%%%BIC caulation
    for order = 1:total_order
        [~,~,~,sigma_sq,~] = OLS_AR(output,order);
        sigma_0 = var(output(order+1:end));                     %%empirical sigma_0;
        BIC(order) = log(sigma_sq/sigma_0)+ order * log(T)/T;   %%following the formula on slides
    end 
%%%caculating BIC^2
BIC_sq = BIC.^2;
%%%final optial order by minimizing BIC
optimal_order = find(BIC == min(BIC(:)));
plot(BIC,'o-');
title('BIC')
%%% use opitimal order to model again
 [coeff,std_err,residual,~] = OLS_AR(output,3);
 t = 40;
 %%% caculating the acs
 [acs,acs_std_err] = my_acs_fun (residual,t);
 figure;
 plot(0:(t-1),acs,'x');
 title('ACS')
 hold on
 errorbar(0:(t-1),zeros(1,t),2*acs_std_err);                   %%plotting 2 standard errorbar around zero
 
 