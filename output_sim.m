%%Input:
% A  --> parameter A   fau--> \phi     T--> samples of output
% alpha -->\alpha      vsnr -->variance of signal to noise ratio

% Output:
% u -->u_t s-->s_t  y-->y_t h-->FIR filter var_y -->empirical variance of y
% var_s -->empirical variance of s   var_u -->empirical variance of u
% var_y -->empirical variance of y   theo_y --> theoretical variance of y 
% theo_u --> theoretical variance of s theo_u --> theoretical variance of u
function [u,s,y,h, var_u, var_y, var_s,theo_u,theo_y,theo_s] = output_sim(A,fau,alpha,vsnr,T)
    h = [A,-2*A*alpha,A];             % create the h filter
    r_0 = vsnr;                       % r_0 = sigma_s^2 = var(n)*vsnr = 1*vsnr(n)
    eps   = normrnd(0, 1, T, 1);      % white noise u = 0; sigma = 1
    
    %%% cacluating the sigma_eta by the relationship deducted in Q1
    sigma_eta = sqrt((r_0*(1-fau*fau))/((1-4*alpha*fau+fau*fau+2*alpha*alpha)*(2*A*A)));                         
    eta   = normrnd(0, sigma_eta, T+length(h)-1, 1); 
    u = zeros(T,1);
    u(1) = eta(1);
    %%%simulate the u which is an AR 1 process
    for t = 2:T+length(h)-1           % add few extra points for get 250 and correctly convolved points
        u(t) = fau*u(t-1)+eta(t);     %  to simulate the u 
    end 
    
    s = conv(h,u);                    % perform covolution
    s = s(length(h):end-2);           % trim out the appropriate the signal
    u = u(length(h):end);
    y = s+eps;                        % add noise 
    var_s = var(s);                   % empirical variance s
    var_y = var(y);                   % empirical variance y
    var_u = var(u);                   % empirical variance u 
    theo_s = r_0;                     % theorectial variance 
    theo_y = r_0 + 1;                 % var(s+n) = var(s) + var(n) + 2cov(s,n) = var(s)+var(n) = r_0+1
    theo_u = (sigma_eta^2)/(1-fau^2);  %AR 1 variance is sigma_eta^2/(1-fau^2)
    
    
    
    figure(1)                        % plot  u_t , s_t , y_t figure
    subplot 231
    plot(u);
    axis([1 250 -4 4]);
    xlabel("t(samples)");
    title("u vs t");
    camroll(90)
    subplot 232
    plot(s);
    axis([1 250 -4 4]);
    xlabel("t(samples)");
    title("s vs t");
    camroll(90)
    subplot 233
    plot(y);
    axis([1 250 -4 4]);
    xlabel("t(samples)");
    title("y vs t");
    camroll(90)
    subplot 234
    histogram(u);
    title("histogram(u)");
    axis([-6 6 0 80]);
    subplot 235
    histogram(s);
    title("histogram(s)");
    axis([-6 6 0 80]);
    subplot 236
    histogram(y);
    title("histogram(y)");
    axis([-6 6 0 80]);
    
    figure(2);                       %plot frequency response  
    freqz(h,1);
end








