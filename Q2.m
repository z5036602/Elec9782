clear;clc; 
[u,s,y,h] = output_sim(1,-0.8,1,0.5,1000);       %simulating T= 1000 data points
figure;
subplot 421
FIR_estimates_2 = LSE(y,u,2);                    %find estimates with m = 2 and noisy data y
plot(FIR_estimates_2,'o--');                     %plot the impulse response which are estimates 
hold on 
plot([h,zeros(1,(length(FIR_estimates_2)-length(h))-1)],'x--');  %plot oringinal impulse response
title('Estimated values based on noisy ouput y (m = 2)');
legend('estimated value','true value')

subplot 423
FIR_estimates_4 = LSE(y,u,4);                   %find estimates with m = 4 and noisy data y
plot(FIR_estimates_4,'o--');                    %plot the impulse response which are estimates   
hold on 
plot([h,zeros(1,(length(FIR_estimates_4)-length(h))-1)],'x--');
title('Estimated values based on noisy ouput y (m = 4)');
legend('estimated value','true value')          %plot oringinal impulse response

subplot 425
FIR_estimates_8 = LSE(y,u,8);                   %find estimates with m = 8 and noisy data y
plot(FIR_estimates_8,'o--');                    %.....
hold on 
plot([h,zeros(1,(length(FIR_estimates_8)-length(h)))],'x--');
title('Estimated values based on noisy ouput y (m = 8)');
legend('estimated value','true value')          %.....


subplot 427
FIR_estimates_16 = LSE(y,u,16);                %find estimates with m = 16 and noisy data y
plot(FIR_estimates_16,'o--');                  %.....
hold on 
plot([h,zeros(1,(length(FIR_estimates_16)-length(h)))],'x--');
title('Estimated values based on noisy ouput y (m = 16)');
legend('estimated value','true value')         %.....

%From here, the procedure is the same, except I used clean data s to do
%estimation
subplot 422
FIR_estimates_ture_2 = LSE(s,u,2);             
plot(FIR_estimates_ture_2,'o-');
hold on 
plot([h,zeros(1,(length(FIR_estimates_ture_2)-length(h))-1)],'x--');
title('Estimated values based on clean ouput s (m = 2)');
legend('estimated value','true value')


subplot 424
FIR_estimates_ture_4 = LSE(s,u,4);
plot(FIR_estimates_ture_4,'o-');
hold on 
plot([h,zeros(1,(length(FIR_estimates_ture_4)-length(h))-1)],'x--');
title('Estimated values based on clean ouput s (m = 4)');
legend('estimated value','true value')


subplot 426
FIR_estimates_ture_8 = LSE(s,u,8);
plot(FIR_estimates_ture_8,'o-');
hold on 
plot([h,zeros(1,(length(FIR_estimates_ture_8)-length(h)))],'x--');
title('Estimated values based on clean ouput s (m = 8)');
legend('estimated value','true value')


subplot 428
FIR_estimates_ture_16 = LSE(s,u,16);
plot(FIR_estimates_ture_16,'o-');
hold on 
plot([h,zeros(1,(length(FIR_estimates_ture_16)-length(h)))],'x--');
title('Estimated values based on clean ouput s (m = 16)');
legend('estimated value','true value')
%%
%Section below showed the frequency response of estimated FIR filter
%coefficients.
figure 
subplot 421
[resp,w] = freqz(h,1);                           %% getting frequency response using freqz
plot(w/pi,20*log10(abs(resp)),'-')               % plot true frequency response of the FIR filter
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
hold on 
[resp,w] = freqz(FIR_estimates_2,1);             %% getting frequency response using freqz
plot(w/pi,20*log10(abs(resp)),'--');             %%normalize the gain to dB and frequency w to rad.
legend('estimated frequency response','true frequency response')
%%% Rest of sections are repeative, which plotted 8 graphs, left 4 are
%%% estimated on Noisy data y ,right 4 are on clean data s
subplot 423
[resp,w] = freqz(h,1);
plot(w/pi,20*log10(abs(resp)),'-')
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
hold on 
[resp,w] = freqz(FIR_estimates_4,1);
plot(w/pi,20*log10(abs(resp)),'--');
legend('estimated frequency response','true frequency response')

subplot 425
[resp,w] = freqz(h,1);
plot(w/pi,20*log10(abs(resp)),'-')
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
hold on 
[resp,w] = freqz(FIR_estimates_8,1);
plot(w/pi,20*log10(abs(resp)),'--');
legend('estimated frequency response','true frequency response')


subplot 427
[resp,w] = freqz(h,1);
plot(w/pi,20*log10(abs(resp)),'-')
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
hold on 
[resp,w] = freqz(FIR_estimates_16,1);
plot(w/pi,20*log10(abs(resp)),'--');
legend('estimated frequency response','true frequency response')

subplot 422
[resp,w] = freqz(h,1);
plot(w/pi,20*log10(abs(resp)),'-')
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
hold on 
[resp,w] = freqz(FIR_estimates_ture_2,1);
plot(w/pi,20*log10(abs(resp)),'--');
legend('estimated frequency response','true frequency response')

subplot 424
[resp,w] = freqz(h,1);
plot(w/pi,20*log10(abs(resp)),'-')
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
hold on 
[resp,w] = freqz(FIR_estimates_ture_4,1);
plot(w/pi,20*log10(abs(resp)),'--');
legend('estimated frequency response','true frequency response')


subplot 426
[resp,w] = freqz(h,1);
plot(w/pi,20*log10(abs(resp)),'-')
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
hold on 
[resp,w] = freqz(FIR_estimates_ture_8,1);
plot(w/pi,20*log10(abs(resp)),'--');
legend('estimated frequency response','true frequency response')

subplot 428
[resp,w] = freqz(h,1);
plot(w/pi,20*log10(abs(resp)),'-')
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
hold on 
[resp,w] = freqz(FIR_estimates_ture_16,1);
plot(w/pi,20*log10(abs(resp)),'--');
legend('estimated frequency response','true frequency response')