file = 'emg_1.lvm';
emg = importdata(file,'\t',23);
a = emg.data;
% column 1 in excel sheet, time
emgX=emg.data(:,1);
% column 2 in excel sheet, the amplitude
emgY=emg.data(:,2);


figure(1)
plot(emgX,emgY)
xlabel('Seconds'); ylabel('Amplitude (V)'); legend('Raw EMG signal')
grid on
title('Raw EMG signal ')

%%
figure(2)
% taking absolute values for all amplitude values
rec_emgY=abs(emgY10);
plot(emgX, rec_emgY)
xlabel('Seconds') 
ylabel('Amplitude (V)')
grid on
title('Rectified EMG signal'), legend('Rectified EMG signal')

%%
s = std(emgY)
Ma = max(emgY)
Mi = min(emgY)
r = rms(emgY)

%%
figure(3)
s1 = smooth (rec_emgY,'lowess')
subplot(6,1,1)
plot(emgX, s1)
set(gca, 'Xlim', [3.6,4]) ;
title('Comparison of Different Smoothing Methods for Selected Segment')

s2 = smooth (rec_emgY,'moving')
subplot(6,1,2)
plot(emgX, s2)
set(gca, 'Xlim', [3.6,4]) ;

s3 = smooth (rec_emgY,'loess')
subplot(6,1,3)
plot(emgX, s3)
set(gca, 'Xlim', [3.6,4]) ;

s4 = smooth (rec_emgY,'sgolay')
subplot(6,1,4)
plot(emgX, s4)
set(gca, 'Xlim', [3.6,4]) ;

s5 = smooth (rec_emgY,'rlowess')
subplot(6,1,5)
plot(emgX, s5)
set(gca, 'Xlim', [3.6,4]) ;

s6 = smooth (rec_emgY,'rloess')
subplot(6,1,6)
plot(emgX, s6)
set(gca, 'Xlim', [3.6,4]) ;
xlabel('Seconds') 
ylabel('Amplitude (V)')

%% Histogram
figure(9)
histogram(rec_emgY,1000)
xlabel('Time');ylabel('No. of Samples')
set(gca, 'Xlim', [0,1]) ;
grid on
title('Histogram of Amplitude intensity')

%%
freq = fft (emgY)
m = abs(freq);                               
p = angle(freq);
f = (0:length(freq)-1)*50/length(freq);

subplot(2,1,1)
plot(f,m)
title('Magnitude')

subplot(2,1,2)
plot(f,rad2deg(p))
title('Phase')

%% 
fs = 1000;
y = fft (emgY)
n = length(emgY);          % number of samples
f = (0:n-1)*(fs/n);     % frequency range
power = abs(emgY10).^2/n;    % power of the DFT
plot(f,power)
xlabel('Frequency')
ylabel('Power')

%%
x = 0:pi/100:3*pi;
y = sin(emgY);
freq = medfreq(emgY,fs)
[lHaar, hHaar] = dwt(y, 'haar'); 
plot([lHaar, hHaar])

%%
freq = medfreq(emgY,fs)
plot(emgX,freq)