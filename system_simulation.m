%output:
% y-->y_t s-->s_t x-->x_t VSNR --> VSNR empirical_VSNR --> empirical_VSNR 
% T-->lags a-->a b-->b sigma_eps -->sigma_eps sigma_v -->sigma_v
function [y,s,x,VSNR,empirical_VSNR] = system_simulation(T,a,b,sigma_eps,theta,sigma_v)                           
mu_e  = 0;                                %mean zero
eps   = normrnd(mu_e, sigma_eps, T, 1);   %creating white noises eps
v_ = normrnd(mu_e, sigma_v, T, 1);        %creating whilte noise v
NUM_1 = [1,0-theta];                      %x_t = (1-theta*z^-1) v_t
DEN_1 = 1;                               
x = filter (NUM_1,DEN_1,v_);              %filter the signal 
NUM_2 = b;                                %s_t = b/(1-a^2*z^-2) x_t
DEN_2 = [1,0,-(a^2)];
s = filter(NUM_2,DEN_2,x);                %filter the signal
y = s+eps;                          
%%%VSNR formula deduced from Q1
VSNR = (b^2 *sigma_v^2*(theta^2+1))/(sigma_eps^2*(1-a^4)); 
empirical_VSNR= var(s)/var(eps);    %Emepirical VSNR

