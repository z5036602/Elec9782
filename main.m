clear;
[rho1,rho2,rho3,r_0,output]  = ar3_sim(0.9,0.7,0.5); %%%generate output data points
[coeff,std_err,~,~,noise_var] = OLS_AR(output,3);               %%%perform ar lest square estimation