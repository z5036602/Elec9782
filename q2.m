%%(a)
theta1 = 0.9;
theta2 = -0.9;
sigma=1;
iteration = 10;
order = 1;
theta_1 = zeros(order+1,iteration);
theta_2 = zeros(order+1,iteration);
%%% caculate the wilson for two sets of coefficients 
%%% and run them for numbers of iteration and store the result into the
%%% matrix, finally we plot the row of matrix against iterations.
for k = 1:iteration+1
    theta_1(:,k)=wilson([1+theta1^2;-theta1],order,k-1);
    theta_2(:,k)=wilson([1+theta2^2;-theta2],order,k-1);
end 
figure;
plot([0:10],theta_1(1,:),'o--');
hold on 
plot ([0:10],theta_1(2,:),'x--');
legend('\theta_1','\theta_2')
xlabel('iterations k')
axis([0 10 -1 1.5]);
title('\theta =-0.9')
hold off

figure;
hold on 
plot([0:10],theta_2(1,:),'o--');
plot ([0:10],theta_2(2,:),'x--');
legend('\theta_1','\theta_2')
xlabel('iterations k')
axis([0 10 -1 1.5]);
title('\theta = 0.9')
hold off


%%
%%%(b)
%%%construct MA covariances r0 r1 r2 caculated in (ii)
phi = -0.6;theta = 0.8;lamda = 2;
r0 = lamda+1+(theta+phi)^2+theta^2*phi^2;
r1= -((theta+phi)+(theta+phi)*theta*phi);
r2 = theta*phi; 
iteration = 10;
theta_1 = zeros(2+1,iteration);
%%%run for numbers of iteration to perform spectral factorization for
%%%denominator
for k = 1:iteration+1
    theta_1(:,k)=wilson([r0;r1;r2],2,k-1);
end 
%%%take steady value as the best fit coefficients for forward and backward
%%%filter.
theta_best = theta_1(:,end);
figure;
plot([0:10],theta_1(1,:),'o--');
hold on 
plot ([0:10],theta_1(2,:),'o--');
plot ([0:10],theta_1(3,:),'o--');
legend('\theta_1','\theta_2','\theta_3');
xlabel('iterations k')
title('\phi = -0.6, \theta =0.8,\lambda =2')
hold off
NUM = sqrt(lamda);
DEN = theta_best;
%%
%%(c)
phi = -0.6;
theta = 0.8;
lamda = 2;
T=100;
%%%simulate the AR+MA peocess
[y,s] = AR_MA_simulation(phi,theta,lamda,T);
%%%construct filter caculated from (b)
NUM = sqrt(lamda)/1.7871;
DEN = [1,-0.0383,-0.1503];
%%%foward filtering
output_1 = filter(NUM,DEN,y);
%%%backward filtering
s_est = filter(NUM,DEN,flip(output_1));
%%%flip the time series back.
s_est=flip(s_est);
 figure;
 plot (s_est);
 hold on 
 plot (s-s_est);
 legend("s(estimated)",'error');
 xlabel('Time lags(n)')
 title('joint plot of s(estimated) and error')
