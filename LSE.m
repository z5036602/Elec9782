%input:
%y--> output data of the model u-->input data of the model
%model order to use for modelling
%output:
%FIR_estimates--> a vector contain estimated coefficients 
function FIR_estimates = LSE(y,u,order)
    row = zeros(1,order);                    
    matri = zeros(length(y)-order,order);
%%%constructing X matrix                order is just m 
    for t = order+1:length(y) 
        for i = 1:order             
            row(i) = u(t-i+1);            %FIR, so only u and its delay on each row
                                          % u_t + u_t-1... until hit the
                                          % order m
        end 
        matri(t-order,:) = row;           %put rows together, we got our matrix X
    end 
    X = matri;
    X_T = matri.';
    y = y(order+1:end);
    % performaning matrix caculating for estimates
    FIR_estimates = (X_T*X)\X_T*y;
end 

 %y=y-mean(y);                                          % we knew there is no mean,
                                                         %So I skipped this step, in
                                                         %Q3 I had more
                                                         %discussion about
                                                         %whther or not to
                                                         %perform the mean
                                                         %correction