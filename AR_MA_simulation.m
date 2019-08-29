function [y,s] = AR_MA_simulation(phi,theta,lamda,T)
mu_e  = 0;                                %mean zero
eps   = normrnd(mu_e, lamda, T, 1);       %creating white noises eps
v_ = normrnd(mu_e, 1, T, 1);              %creating whilte noise v

NUM_1 = [1,0-theta];                      %x_t = (1-theta*z^-1) v_
DEN_1 = 1;                               
n = filter (NUM_1,DEN_1,v_);              %filter the signal to get n

NUM_2 = 1;                                %s_t = 1/(1-phi*z^-1) esp
DEN_2 = [1,-phi];
s = filter(NUM_2,DEN_2,eps);               %filter the signal to get s 

y = s+n;                                   %final output y
end