%%%input:
% c_star --> MA covariances order -->system order iteration --> iteration
% theta --> MA coefficients
function [theta] = wilson(c_star,order,iteration)
    
    theta = zeros(1,order+1).';
    theta(1) = 1;
    c = zeros(order+1,1);
    T_L = zeros(order+1,order+1);
    T_R = zeros(order+1,order+1);
    %%%caculate the covariances
    for counter = 1:iteration
        for r = 1:(order+1)
            cov_index = r-1;               %%%rejust the index back to zero
            my_sum = 0;                    %%%this rejustment is caused by matlab is 1 index
                for k = 1:(order-cov_index+1)    
                    my_sum = my_sum + (theta(k))*(theta(k+cov_index));
                end 
            c(r) = my_sum;
        end 
     a = [theta(1),zeros(1,length(theta)-1)];
     b = theta;
     T_R = toeplitz(a,b);                  %%construct toeplitz TR   
     a =  [theta(end),zeros(1,length(theta)-1)];
     T_L = hankel(b,a);                    %%construct hankel TL   
     theta = (T_L+T_R)\(c+c_star);
    end
end