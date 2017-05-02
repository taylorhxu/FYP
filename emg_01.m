file = 'signal_30s.xls';
emg = importdata(file,'\t',23);
a = emg.data;
% column 1 in excel sheet, time
emgX=emg.data(:,1);
% column 2 in excel sheet, the amplitude
emgY=emg.data(:,2);

%% Plot real-time EMG signal
figure(1)
plot(emgX,emgY)
xlabel('Seconds'); ylabel('Amplitude (V)'); legend('Raw Time EMG signal')
grid on
title('Raw EMG signal Case 3')

%% Rectifying the signal
figure(2)
rec_emgY=abs(emgY);     % taking absolute values for all amplitude values
plot(emgX, rec_emgY)
xlabel('Seconds') 
ylabel('Amplitude (V)')
grid on
title('Rectified EMG signal Case 3'), legend('Rectified EMG signal')

%% PSD
figure(3)
fs = 1000;
n = length (emgY);
Y = fft(emgY);
Pyy = Y.*conj(Y);
f = fs*(0:n/2-1);
nyquist = 1/(2*0.001);
freq = (1:n/2)/(n/2)*nyquist;
plot(freq,Pyy(1:n/2))
grid on;
title('Power Spectral Density 3');
xlabel('Frequency (Hz)');
ylabel('Power');

%% Plot figure 1,2,3 in one figure
figure(4)
subplot(3,1,3)
fs = 1000;
n = length (emgY);
Y = fft(emgY);
Pyy = Y.*conj(Y);
f = fs*(0:n/2-1);
nyquist = 1/(2*0.001);
freq = (1:n/2)/(n/2)*nyquist;
P = Pyy(1:n)
plot(freq,Pyy(1:n/2))
grid on;
title('Power spectral density');
xlabel('Frequency (Hz)');
ylabel('Power');


subplot(3,1,2);
plot(emgX, rec_emgY);
xlabel('Seconds (s)') ;
ylabel('Amplitude (V)');
grid on;
title('Rectified EMG Signal'), legend('Rectified EMG signal')

subplot(3,1,1)
plot(emgX, emgY);
xlabel('Seconds (s)') ;
ylabel('Amplitude (V)');
grid on;
title('Raw EMG Signal'), legend('Raw EMG signal')

%% Numerical Values
Ma = max(emgY)
Mi = min(emgY)
r = rms(rec_emgY)
s = std(emgY)
freq1 = medfreq(emgY,fs)
freq2 = meanfreq(emgY,fs)

% %% DWT /CWT 
% [lHaar, hHaar] = dwt(emgY, 'haar'); 
% figure(5)
% subplot(1,2,1);
% plot([lHaar, hHaar])
% subplot(1,2,2);
% [lHaar2, hHaar2] = cwt(emgY, 'morse'); 
% plot([lHaar2, hHaar2])

%% RMS envelope with Raw EMG Signal
E = envelope(emgY,150,'rms')
figure(6)
plot (emgX,emgY)
hold on 
plot(emgX,E,'rd')
xlabel('Seconds (s)') ;
ylabel('Amplitude (V)');
grid on;
title('EMG Signal with RMS envelope')

%% Peak Envelope 
figure(7)
[yupper,ylower] = envelope(emgY,500,'peak') 
plot ([yupper,ylower] )
hold on 
plot (emgY,'k')
xlabel('Samples') ;
ylabel('Amplitude (V)');
title('EMG Signal with Peak envelope')
%% Wavelet Transform Fail
% wt = cwt(emgY,1000)
% plot (wt)

% %% Wavelet Fail
% freq = 20: .1 :500;
% fs = scal2frq (freq, 'cmor4-2.5', 0.004);
% C = cwt(emgY (1:length(emgY)) ,fs, 'cmor4-2.5')
% coefs = wcodemat(abs(C),80,'mat',1);
% image ( (1:length(emgY))./250, wrev(freq), coefs);
% xlabel('Time (s)') ;
% ylabel('Frequency (Hz)');
% title('Time Frequency Analysis using CWT')

%% WT Denoising
[SIGDEN,~,thrParams,~,BestNbOfInt] = cmddenoise(emgY,'db3',6);

plot(emgY,'k')
hold on;
set(gca, 'Xlim', [500,1000]) ;

plot(SIGDEN)
title('Denoised Signal vs. Original Signal')
set(gca, 'Xlim', [500,1000]) ;
grid on
xlabel('No. of Samples'); ylabel('Amplitude (V)');
legend('Original Signal','Denoised Signal','Location','NorthEastOutside')

% %% DWT Haar
% x = emgY
% sampling_rate = 1000
% 
% subplot(4,2,1)
% plot(x);
% xlabel('Time (seconds)');
% title('Oringinal Signal');
% axis([0 256 -1 1]);
% 
% subplot(4,2,2)
% scale_level =  1;
% y = DWT2(x, sampling_rate, scale_level);
% xlabel('Time (seconds)');
% ylabel('Frequency (Hz)');
% title('Scale Level = 1');
% 
% subplot(4,2,3)
% scale_level =  2;
% y = DWT2(x, sampling_rate, scale_level);
% xlabel('Time (seconds)');
% ylabel('Frequency (Hz)');
% title('Scale Level = 2');
% 
% subplot(4,2,4)
% scale_level =  3;
% y = DWT2(x, sampling_rate, scale_level);
% xlabel('Time (seconds)');
% ylabel('Frequency (Hz)');
% title('Scale Level = 3');
% 
% subplot(4,2,5)
% scale_level =  4;
% y = DWT2(x, sampling_rate, scale_level);
% xlabel('Time (seconds)');
% ylabel('Frequency (Hz)');
% title('Scale Level = 4');
% 
% subplot(4,2,6)
% scale_level =  5;
% y = DWT2(x, sampling_rate, scale_level);
% xlabel('Time (seconds)');
% ylabel('Frequency (Hz)');
% title('Scale Level = 5');
% 
% subplot(4,2,7)
% scale_level =  6;
% y = DWT2(x, sampling_rate, scale_level);
% xlabel('Time (seconds)');
% ylabel('Frequency (Hz)');
% title('Scale Level = 6');
% 
% subplot(4,2,8)
% scale_level =  7;
% y = DWT2(x, sampling_rate, scale_level);
% xlabel('Time (seconds)');
% ylabel('Frequency (Hz)');
% title('Scale Level = 7');
