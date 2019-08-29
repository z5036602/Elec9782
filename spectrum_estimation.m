%%% simulate the system to generate (y,x,s)
T = 1000;
a = 0.8;
b = 1;
sigma_eps =1;
theta = 0.7;
sigma_v = 1;
[y,s,x,VSNR,empirical_VSNR] = system_simulation(T,a,b,sigma_eps,theta,sigma_v);
figure;
subplot 311
plot(x);
title('x_t')
axis ([0 1000 -5 5]);
subplot 312
plot(s);
title('s_t')
axis ([0 1000 -5 5]);
subplot 313
plot(y);
title('y_t')
axis ([0 1000 -5 5]);
%%
frequency_range = (0:pi/1000:(pi-pi/1000))/(2*pi);
figure;
subplot 522
%%%caculate the cross-covariances for different time lags t=40...80 
%%%then estimate the spectrum from the empirical cross-correlation
%%%fianlly plot the result
t = 40;                                      
acs = empirical_cross_autocorr(y,x,t);      
[spectrum] = spectrum_estimator(acs,t);  
plot (frequency_range,real(spectrum));
title('F_{yx}(\omega) for increasing M')
axis([0 3.3/(2*pi) -5 5]);
subplot 521
plot([-t:t],acs);
title('Cross ACS');
ylabel('M=40');
axis([-85,85,-1,1])
subplot 524
t = 50;                     %% lag numebrs 
acs = empirical_cross_autocorr(y,x,t);
[spectrum] = spectrum_estimator(acs,t);
plot (frequency_range,real(spectrum));
axis([0 3.3/(2*pi) -5 5]);
subplot 523
plot([-t:t],acs);
ylabel('M=50');
axis([-85,85,-1,1])
subplot 526
t = 60;                     %% lag numebrs 
acs = empirical_cross_autocorr(y,x,t);
[spectrum] = spectrum_estimator(acs,t);
plot (frequency_range,real(spectrum));
axis([0 3.3/(2*pi) -5 5]);
subplot 525
plot([-t:t],acs);
ylabel('M=60');
axis([-85,85,-1,1])
subplot 528
t = 70;                     %% lag numebrs 
acs = empirical_cross_autocorr(y,x,t);
[spectrum] = spectrum_estimator(acs,t);
plot (frequency_range,real(spectrum));
axis([0 3.3/(2*pi) -5 5]);
subplot 527
plot([-t:t],acs);
ylabel('M=70');
axis([-85,85,-1,1])
subplot (5,2,10)
t = 80;                     %% lag numebrs 
acs = empirical_cross_autocorr(y,x,t);
[spectrum] = spectrum_estimator(acs,t);
plot (frequency_range,real(spectrum));
xlabel('frequency f')
axis([0 3.3/(2*pi) -5 5]);
subplot 529
plot([-t:t],acs);
ylabel('M=80');
axis([-85,85,-1,1])
xlabel('lag r')

%%
frequency_range = (0:pi/1000:(pi-pi/1000))/(2*pi);
figure;
subplot 522
%%%caculate the auto-covariances for different time lags t=40...80 
%%%then estimate the spectrum from the empirical cross-correlation
%%%fianlly plot the result
t = 40;                     %% lag numebrs 
acs = empirical_autocorr(x,t);
[spectrum] = spectrum_estimator(acs,t);
plot (frequency_range,real(spectrum));
title('F_x(\omega) for increasing M')
axis([0 3.3/(2*pi) -5 5]);
subplot 521
plot([-t:t],acs);
title('ACS');
ylabel('M=40');
axis([-85,85,-1,1])
subplot 524
t = 50;                     %% lag numebrs 
acs = empirical_autocorr(x,t);
[spectrum] = spectrum_estimator(acs,t);
plot (frequency_range,real(spectrum));
axis([0 3.3/(2*pi) -5 5]);
subplot 523
plot([-t:t],acs);
ylabel('M=50');
axis([-85,85,-1,1])
subplot 526
t = 60;                     %% lag numebrs 
acs = empirical_autocorr(x,t);
[spectrum] = spectrum_estimator(acs,t);
plot (frequency_range,real(spectrum));
axis([0 3.3/(2*pi) -5 5]);
subplot 525
plot([-t:t],acs);
ylabel('M=60');
axis([-85,85,-1,1])
subplot 528
t = 70;                     %% lag numebrs 
acs = empirical_autocorr(x,t);
[spectrum] = spectrum_estimator(acs,t);
plot (frequency_range,real(spectrum));
axis([0 3.3/(2*pi) -5 5]);
subplot 527
plot([-t:t],acs);
ylabel('M=70');
axis([-85,85,-1,1])
subplot (5,2,10)
t = 80;                     %% lag numebrs 
acs = empirical_autocorr(x,t);
[spectrum] = spectrum_estimator(acs,t);
plot (frequency_range,real(spectrum));
xlabel('frequency f')
axis([0 3.3/(2*pi) -5 5]);
subplot 529
plot([-t:t],acs);
ylabel('M=80');
axis([-85,85,-1,1])
xlabel('lag r')


%%
frequency_range = (0:pi/1000:(pi-pi/1000))/(2*pi);
%%%plot original F_x for f=0...w/2pi
F_x = zeros(1,1000);
w = 0;
for i = 1:1000
    F_x(i) = sigma_v^2*(1+theta^2-2*theta*cos(w));
    w = w+pi/1000;
end
figure;
plot (frequency_range,real(F_x),'--');
hold on 
%%%plot the estimates of spectrum F_x for lag t= 10...40
for t = 10:10:40
    acs = empirical_autocorr(x,t);
    [spectrum] = spectrum_estimator(acs,t);
    plot (frequency_range,real(spectrum));
end
legend('True','M=10','M=20','M=30','M=40');
xlabel('frequency f');
title('Estimates of spectrum F_x');
axis([0 0.5 0 10])
hold off
%%
frequency_range = (0:pi/1000:(pi-pi/1000))/(2*pi);
F_yx = zeros(1,1000);
w = 0;
%%%plot original F_yx for f=0...w/2pi
for i = 1:1000
    F_yx(i) = (b/(1-a^2*exp(-2j*w)))*sigma_v^2*(1+theta^2-2*theta*cos(w));
    w = w+pi/1000;
end
figure;
plot (frequency_range,real(F_yx),'--');
hold on 
%%%plot the estimates of spectrum F_yx for lag t= 10...40
for t = 10:10:40
    acs = empirical_cross_autocorr(y,x,t);
    [spectrum] = spectrum_estimator(acs,t);
    plot (frequency_range,real(spectrum));
end
legend('True','M=10','M=20','M=30','M=40');
xlabel('frequency f');
title('Estimates of cross spectrum F_{yx}');
axis([0 0.5 0 10])
hold off
%%
frequency_range = (0:pi/1000:(pi-pi/1000))/(2*pi);
mag_h = zeros(1,1000);
w = 0;
%%%plot original transfer function h for f=0...w/2pi
for i = 1:1000
    mag_h(i) = b/(1-a^2*exp(-2j*w));
    w = w+pi/1000;
end

figure;
plot (frequency_range,abs(mag_h),'--');
hold on 
%%%plot the estimates of transfer function h for lag t= 10...40
for t = 10:10:40
    acs = empirical_autocorr(x,t);
    [spectrum_x] = spectrum_estimator(acs,t);
    acs = empirical_cross_autocorr(y,x,t);
    [spectrum_yx] = spectrum_estimator(acs,t);
    estimated_h = spectrum_yx./spectrum_x;
    plot (frequency_range,abs(estimated_h));
end
legend('True','M=10','M=20','M=30','M=40');
xlabel('frequency f');
title('Estimates of transfer function h');
axis([0 0.5 0 10])
hold off
