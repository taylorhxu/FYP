file = 'signal-02.xlsx';
emg = importdata(file);
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
title('Raw EMG signal Case 9')

%% rectifying the signal
figure(2)
% taking absolute values for all amplitude values
rec_emgY=abs(emgY10);
plot(emgX, rec_emgY)
xlabel('Seconds') 
ylabel('Amplitude (V)')
grid on
title('Rectified EMG signal Case 9'), legend('Rectified EMG signal')

%%
fs = 1000;                  %sampling frequency
y = fft (emgY)
n = length(emgY);           % number of samples
f = (0:n-1)*(fs/n);         % frequency range
power = abs(emgY).^2/n;     % power of the DFT

figure()
plot(f,power)
xlabel('Frequency(Hz)')
ylabel('Power')
grid on
title('EMG signal Power Case 9')
