FIR_estimated_matrix = zeros(50,4);
for B = 1:50
    [u,s,y,h] = output_sim(1,-0.8,1,0.5,1000);        %perform simulation for each estimation  
    FIR_estimates_4 = LSE(y,u,4);                     %perform estimation with order 4 
    FIR_estimated_matrix(B,:) = FIR_estimates_4;      %construct estimatied coefficients matrix for histogram plots 
end                                                   %rows are 4 coefficients for one estimation
figure;
subplot 411
histogram(FIR_estimated_matrix(:,1),10);              %histogram on first column(first coefficient)
axis([0 2 0 15]);
subplot 412
histogram(FIR_estimated_matrix(:,2),10);              %histogram on second column(second coefficient)
subplot 413
histogram(FIR_estimated_matrix(:,3),10);              %histogram on third column(third coefficient)
axis([0 2 0 20]);
subplot 414
histogram(FIR_estimated_matrix(:,4),10);              %histogram on fourth column(fourth coefficient)
axis([-1 1 0 20]);