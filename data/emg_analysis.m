file = 'emg_6.lvm';
emg = importdata(file,'\t',23);
a = emg.data;
% column 1 in excel sheet, time
emgX=emg.data(:,1);
% column 2 in excel sheet, the amplitude
emgY=emg.data(:,2);

%% Plot real-time EMG signal
figure(1)
plot(emgX,emgY)
xlabel('Seconds'); ylabel('Amplitude (V)'); legend('Real Time EMG signal')
grid on
title('Raw EMG signal Case 1')

%% rectifying the signal
figure(2)
% taking absolute values for all amplitude values
rec_emgY=abs(emgY);
plot(emgX, rec_emgY)
xlabel('Seconds') 
ylabel('Amplitude (V)')
grid on
title('Rectified EMG signal'), legend('Rectified EMG signal Case 1')

%% segemented normal EMG
figure (3)
plot(emgX, rec_emgY);
set(gca, 'Xlim', [10,15]) ;
set(gca, 'Ylim', [0,3]) ;
xlabel('Seconds') ;
ylabel('Amplitude (V)');
grid on;
title('Segmented normal EMG signal ');

%% segemented EMG signal under physiological stress
figure (4)
plot(emgX, rec_emgY);
set(gca, 'Xlim', [22,25]) ;
xlabel('Seconds') ;
ylabel('Amplitude (V)');
grid on;
title('Segmented EMG signal under Physiologcial Stress');

%% normal vs. stress
figure (5)
subplot(2,1,1)
plot(emgX, rec_emgY);
set(gca, 'Xlim', [1,2]) ;
set(gca, 'Ylim', [0,1.4]) ;
xlabel('Seconds') ;
ylabel('Amplitude (V)');
title('Segmented normal EMG signal ');

subplot(2,1,2)
plot(emgX, rec_emgY);
set(gca, 'Xlim', [0.3, 1]) ;
xlabel('Seconds') ;
ylabel('Amplitude (V)');
title('Segmented EMG signal under Physiologcial Stress');

%% X axis limit values changes for each case based on the peaks observed
figure()
s1 = smooth (rec_emgY,'lowess')
subplot(6,1,1)
plot(emgX, s1)
set(gca, 'Xlim', [8, 9]) ;
title('Comparison of Different Smoothing Methods for Selected Segment')

s2 = smooth (rec_emgY,'moving')
subplot(6,1,2)
plot(emgX, s2)
set(gca, 'Xlim', [8, 9]) ;

s3 = smooth (rec_emgY,'loess')
subplot(6,1,3)
plot(emgX, s3)
set(gca, 'Xlim', [8, 9]) ;

s4 = smooth (rec_emgY,'sgolay')
subplot(6,1,4)
plot(emgX, s4)
set(gca, 'Xlim', [8, 9]) ;

s5 = smooth (rec_emgY,'rlowess')
subplot(6,1,5)
plot(emgX, s5)
set(gca, 'Xlim', [8, 9]) ;

s6 = smooth (rec_emgY,'rloess')
subplot(6,1,6)
plot(emgX, s6)
set(gca, 'Xlim', [8, 9]) ;
xlabel('Seconds') 
ylabel('Amplitude (V)')

%% Selected smoothing filter
figure(7)
plot(emgX, s5)
xlabel('Seconds') 
ylabel('Amplitude (V)')

%%
Ma = max(emgY)
Mi = min(emgY)
r = rms(emgY)
s = std(emgY)
%%
[yupper,ylower] = envelope(rec_emgY,10,'peak')
plot([yupper,ylower])
%%
[yupper1,ylower1] = envelope(emgY,150,'rms') 
plot([yupper1,ylower1])

%% Histogram
figure(9)
histogram(emgY,1000)
xlabel('Amplitude (V)');ylabel('No. of Samples')
set(gca, 'Xlim', [-0.5,0.5]) ;
grid on
title('Histogram of Amplitude intensity')

%%
fs = 1000;                  %sampling frequency
y = fft (emgY)
n = length(emgY);           % number of samples
f = (0:n-1)*(fs/n);         % frequency range
power = abs(emgY).^2/n;     % power of the DFT

figure(11)
plot(f,power)
xlabel('Frequency')
ylabel('Power')
grid on
title('EMG Signal Power Case 1')


%%
sm = smooth (rec_emgY,'sgolay')
plot(emgX, sm)
hold on 
plot(freq,Pyy(1:n/2))
grid on;
