%input:
%y--> output data of the model u-->input data of the model
%model order to use for modelling
%output:
%coeff--> a vector contain estimated coefficients 
%std_err--> standard error of estimates
%residual--> resiual of the esitmator
%sigma_sq -->variance of residual
%noise_var-->estimated noise variance
function [coeff,std_err,residual,sigma_sq,noise_var] = OLS_AR(y,order)
    y=y-mean(y);
    z = mean(y);
    row = zeros(1,order);
    matri = zeros(length(y)-order,order);
    for t = order+1:length(y)             %creating X matrix
        for i = 1:order 
            row(i) = y(t-i);
            
        end 
        matri(t-order,:) = row;
    end 
    X = matri;                             %X
    X_T = matri.';                         %X^T
    y = y(order+1:end);                    %y m...T
    coeff = (X_T*X)\X_T*y;                 %inv(X*X^t)*X^T*y
    std_err_mat = var(y)*inv(X_T*X);       
    std_err = sqrt(diag(std_err_mat));     % sqrt of diagonal of variance of beta(estimator)... 
                                           %= standard error of estimator
    residual = y - X*coeff;                % residual
    sigma_sq = var (residual);             % sigma_sq for BIC caculation (variance of residual)
    
 if (order == 3)
   rho1 = coeff(1);
   rho2 = coeff(2);
   rho3 = coeff(3);
%%%caculating empirical \gamma_0
    my_sum = 0;
       for k = 1:length(y)
           my_sum = my_sum + (y(k)-mean(y))*(y(k)-mean(y)); 
       end 
    r_0 = my_sum/length(y);                         

%%% Noise variance estimator from relationship between r_0 and sigma^2,
%%% deducted from correation of the signal with itself.
    noise_var = (1-rho3^2-(4*rho1*rho2*rho3+rho1^2+rho2^2+rho1^2*rho2-rho2^3+...
    rho1^3*rho3+rho1^2*rho3^2-rho1*rho2^2*rho3+rho2^2*rho3^2)/(1-rho2-rho1*rho3-rho3^2))*r_0;
 end
    noise_var = 0;
end