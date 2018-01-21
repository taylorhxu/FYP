close all; clear all; clc;
%problem 11.1
%%import the data in the file  and plot the signal
problem11_1 =xlsread('\\tsclient\E\BIOM480A3\Hw5\p11_1.xls');
t = problem11_1(:, 1);
y1 = problem11_1(:, 2);
N = length(y1);% find the length of the data per second
ls = size(y1); %% size
f = 1/N;% find the sampling rate or frequency
fs = 3000;
T = 1/fs % period between each sample
t1 = (0 : N-1) *T;%t = (0:1:length(y1)-1)/fs; % sampling period
Nyquist = fs/2;
figure;
subplot (3,1,1), plot(t,y1,'b');     
title ('EMG signal of single muscle 40 month old patient ');
xlabel ('time (sec)');
ylabel ('Amplitute (V)');
grid on;
Y= abs(fft(y1));
Y(1) = [];
power = abs(Y(1:N/2)).^2;
nyquist = 1/(2*0.001);
freq = (1:N/2)/(N/2)*nyquist;
subplot(212), plot(freq,power), grid on
xlabel('Sample number (in Frequency)')
ylabel('Power spectrumen');
title({'Single-sided Power spectrum' ...
    ' (Frequency in shown on a log scale)'});
axis tight

%%% RMS of the signal
rms_y1 = sqrt(mean(y1.^2));
msgbox(strcat('RMS of EMG signal is = ',mat2str(rms_y1), ''));
rms_emg = rms (y1);

%%%%%AVR of the signal
arv_y1 = abs(mean(y1));
msgbox(strcat('ARV of EMG signal is = ',mat2str(arv_y1), ''));

%% remove any DC offset of the signal
y2 = detrend(y1);   %% y2 is the singal without DC offset
figure;
rec_y = abs(y2);
plot (rec_y);
xlabel('Sample number (in Frequency)')
ylabel('Rectified EMG signal');
title({'Rectified EMG signal' ...
    ' (Frequency in shown on a log scale)'});
figure;
xdft = fft(y1);
xdft = xdft(1:N/2+1);
psdx = (1/(fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:fs/length(y1):fs/2;
plot(freq,10*log10(psdx))
grid on
title(' Power spectrum FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
%%%  DFT to describe the signal in the frequency
NFFT = 2 ^ nextpow2(N);
Y = fft(y1, NFFT) / N;
f = (fs / 2 * linspace(0, 1, NFFT / 2+1))'; % Vector containing frequencies in Hz
amp = ( 2 * abs(Y(1: NFFT / 2+1))); % Vector containing corresponding amplitudes
figure;
plot (f, amp);
title ('plot single-sided amplitude spectrume of the  EMG signal')
xlabel ('frequency (Hz)')
ylabel ('|y(f)|')
grid on;

%%%%%%%%%%% problem 11.6%%%
close all;
clear all;
clc;

%%import the data in the file "P-10_3.xls"  and plot the signal
problem11_6 =xlsread('\\tsclient\E\BIOM480A3\Hw5\p_11_6.xls');
Frame = problem11_6(:,1);
LFSW = problem11_6(:,2);
RFSW = problem11_6(:,3);
EMG1 = problem11_6(:,4);
EMG2 = problem11_6(:,5);
EMG3 = problem11_6(:,6);
EMG4 = problem11_6(:,7);
EMG5 = problem11_6(:,8);
EMG6 = problem11_6(:,9);
EMG7 = problem11_6(:,10);
EMG8 = problem11_6(:,11);
EMG9 = problem11_6(:,12);
EMG10 = problem11_6(:,13);
fs = 30000;% sampling rate or frequency (Hz)
N = length(EMG1);% find the length of the data per second
T = 1/fs % period between each sample
ls = size(EMG1); %% size
fs2 = 1/ N;% find the sampling rate or frequency
t = (0 : N-1)/fs;
t1 = (0 : N-1) *T;%t = (0:1:length(y1)-1)/fs; % sampling period
Nyquist = fs/2;
figure;
   subplot (3,1,1),plot(Frame,EMG1,'b');     
title ('EMG1 signal ')
xlabel ('Frame')
ylabel ('Amplitute of EMG1 data (v)')
grid on;

Y= abs(fft(EMG1));
Y(1) = [];
power = abs(Y(1:N/2)).^2;
nyquist = 1/(2*0.001);
freq = (1:N/2)/(N/2)*nyquist;
subplot(212), plot(freq,power), grid on
xlabel('Sample number (in Frequency)')
ylabel('Power spectrumen');
title({'Single-sided Power spectrum for EMG1' ...
    ' (Frequency in shown on a log scale)'});
axis tight

%%% RMS of the signal
rms_EMG1 = sqrt(mean(EMG1.^2));
msgbox(strcat('RMS of EMG1 signal is = ',mat2str(rms_EMG1), ''));
rms1 = rms(EMG1);

%%%%%AVR of the signal
arv_EMG1 = mean(abs(EMG1));
msgbox(strcat('ARV of EMG1 signal is = ',mat2str(arv_EMG1), ''));



%% remove any DC offset of the signal
y2 = detrend(EMG1);   %% y2 is the singal without DC offset
figure;
rec_y = abs(y2);
plot (rec_y);
xlabel('Sample number (in Frequency)')
ylabel('Rectified EMG1 signal');
title({'Rectified EMG1 signal' ...
    ' (Frequency in shown on a log scale)'});


%% 11.6C%%%

problem11_6 =xlsread('\\tsclient\E\BIOM480A3\Hw5\EMG6.xls');

EMG6 = problem11_6(:,1);
Frame = problem11_6(:,2);
fs = 3000;% sampling rate or frequency (Hz)
N = length(EMG6);% find the length of the data per second
T = 1/fs % period between each sample
ls = size(EMG6); %% size
fs2 = 1/ N;% find the sampling rate or frequency
t = (0 : N-1)/fs;
t1 = (0 : N-1) *T;%t = (0:1:length(y1)-1)/fs; % sampling period
Nyquist = fs/2;
figure;
   subplot (3,1,1),plot(Frame,EMG6,'b');    
title ('EMG6 signal ')
xlabel ('Frame (samples at 3000Hz')
ylabel ('Amplitute of EMG6 data (v)')
grid on;

Y= abs(fft(EMG6));
Y(1) = [];
power = abs(Y(1:N/2)).^2;
nyquist = 1/(2*0.001);
freq = (1:N/2)/(N/2)*nyquist;
subplot(212), plot(freq,power), grid on
xlabel('Sample number (Frequency at 3000Hz)')
ylabel('Power spectrumen');
title({'Single-sided Power spectrum for EMG6' ...
    ' (Frequency in shown on a log scale)'});
axis tight

%%% RMS of the signal
rms_EMG6 = sqrt(mean(EMG6.^2));
msgbox(strcat('RMS of EMG6 signal is = ',mat2str(rms_EMG6), ''));

%%%%%AVR of the signal
arv_EMG6 = mean(abs(EMG6));
msgbox(strcat('ARV of EMG6 signal is = ',mat2str(arv_EMG6), ''));

%% remove any DC offset of the signal
y2 = detrend(EMG6);   %% y2 is the singal without DC offset
figure;
rec_y = abs(y2);
plot (rec_y);
xlabel('Sample number (Frequency at 3000Hz)')
ylabel('Rectified EMG6 signal');
title({'Rectified EMG6 signal' ...
    ' (Frequency in shown on a log scale)'});
figure;
   subplot (3,1,1),plot(Frame,EMG7,'b');    
title ('EMG7 signal ')
xlabel ('Frame (Sample at 3000Hz')
ylabel ('Amplitute of EMG7 data (v)')
grid on;

Y= abs(fft(EMG7));
Y(1) = [];
power = abs(Y(1:N/2)).^2;
nyquist = 1/(2*0.001);
freq = (1:N/2)/(N/2)*nyquist;
subplot(212), plot(freq,power), grid on
xlabel('Sample number (Frequency at 3000Hz)')
ylabel('Power spectrumen');
title({'Single-sided Power spectrum for EMG7' ...
    ' (Frequency in shown on a log scale)'});
axis tight

%%% RMS of the signal
rms_EMG7 = sqrt(mean(EMG7.^2));
msgbox(strcat('RMS of EMG7 signal is = ',mat2str(rms_EMG7), ''));

%%%%%AVR of the signal
arv_EMG7 = mean(abs(EMG7));
msgbox(strcat('ARV of EMG7 signal is = ',mat2str(arv_EMG7), ''));

%% remove any DC offset of the signal
y2 = detrend(EMG7);   %% y2 is the singal without DC offset
figure;
rec_y = abs(y2);
plot (rec_y);
xlabel('Sample number (at Frequency 3000Hz)')
ylabel('Rectified EMG7 signal');
title({'Rectified EMG7 signal' ...
    ' (Frequency in shown on a log scale)'});
%%11.6 d and e
EMG6_1 =xlsread('J:\BIOM480A3\Hw5\EMG6.xls');
EMG6 = EMG6_1(:,1);
Frame1 = EMG6_1(:,2);
N1 = length(EMG6);% find the length of the data per second
T = 1/fs % period between each sample
ls1 = size(EMG6); %% size
fs2 = 1/ N1;% find the sampling rate or frequency
t6 = (0 : N1-1)/fs;
t1 = (0 : N1-1) *T; %t = (0:1:length(y1)-1)/fs; % sampling period
Nyquist = fs/2;
%subplot (11),
   plot(Frame1,EMG6,'b');    
title ('EMG6 signal ')
xlabel ('Frame (Sample at 3000Hz)')
ylabel ('Amplitute of EMG6 data (v)')
grid on;
figure;
   %subplot (12),
   plot(Frame,EMG7,'b');    
title ('EMG7 signal ')
xlabel ('Frame (Sample at 3000Hz)')
ylabel ('Amplitute of EMG7 data (v)')
grid on;
%%%% EMG6 during contraction
y2 = EMG6(780:1350);
Frame12 = Frame1(780:1350);
N2 = length(y2);% find the length of the data per second
t6_2 = (0 : N2-1)/fs;
t1_2 = (0 : N2-1) *T; %t = (0:1:length(y1)-1)/fs; % sampling period
Nyquist = fs/2;
figure;
   %subplot (211),
   plot(Frame12,y2,'b');    
title ('during contraction of EMG6 signal')
xlabel ('Frame (Sample at 3000Hz)')
ylabel ('Amplitute of EMG6 data (v)')
grid on;

%%%  DFT to describe the signal in the frequency
NFFT = 2 ^ nextpow2(N2);
Y = fft(y2, NFFT) / N2;
f = (fs / 2 * linspace(0, 1, NFFT / 2+1))'; % Vector containing frequencies in Hz
amp = ( 2 * abs(Y(1: NFFT / 2+1))); % Vector containing corresponding amplitudes
figure;
%subplot (212),
plot (f, amp);
title ('Single-sided amplitude spectrume for during contraction of adductor (EMG6)signal')
xlabel ('frequency (Hz)')
ylabel ('|y(f)|')
grid on;
%%% EMG7 contraction
figure;
y3 = EMG7(825:1020);
Frame13 = Frame(825:1020);
N3 = length(y3);% find the length of the data per second
   subplot(211),
   plot(Frame13,y3,'b');    
title ('during contraction of EMG7 signal')
xlabel ('Frame (Sample at 3000Hz)')
ylabel ('Amplitute of EMG7 data (v)')
grid on;

%%%  DFT to describe the signal in the frequency
NFFT3 = 2 ^ nextpow2(N3);
Y3 = fft(y3, NFFT3) / N3;
f3 = (fs / 2 * linspace(0, 1, NFFT3 / 2+1))'; % Vector containing frequencies in Hz
amp3 = ( 2 * abs(Y3(1: NFFT3 / 2+1))); % Vector containing corresponding amplitudes
subplot (212),
%figure;
plot (f3, amp3);
title ('Single-sided amplitude spectrume for during contraction EMG7 signal')
xlabel ('frequency (Hz)')
ylabel ('|y(f)|')
grid on;
%%%% EMG6 during onset
y4 = EMG6(1410:1500);
Frame14 = Frame1(1410:1500);
N4 = length(y4);% find the length of the data per second
figure;
   %subplot (211),
   plot(Frame14,y4,'b');    
title ('during onset of EMG6 signal')
xlabel ('Frame (Sample at 3000Hz)')
ylabel ('Amplitute of EMG6 data (v)')
grid on;
%%%  DFT to describe the signal in the frequency
NFFT4 = 2 ^ nextpow2(N4);
Y4 = fft(y4, NFFT4) / N4;
f4 = (fs / 2 * linspace(0, 1, NFFT4 / 2+1))'; % Vector containing frequencies in Hz
amp4 = ( 2 * abs(Y4(1: NFFT4 / 2+1))); % Vector containing corresponding amplitudes
figure;
%subplot (212),
plot (f4, amp4);
title ('Single-sided amplitude spectrume for during onset of adductor (EMG6)signal')
xlabel ('frequency (Hz)')
ylabel ('|y(f)|')
grid on;
%%% EMG7 onset
figure;
y5 = EMG7(1055:1300);
Frame15 = Frame(1055:1300);
N5 = length(y5);% find the length of the data per second
   %subplot(211),
   plot(Frame15,y5,'b');    
title ('during onset of EMG7 signal')
xlabel ('Frame (Sample at 3000Hz)')
ylabel ('Amplitute of EMG7 data (v)')
grid on;
%%%  DFT to describe the signal in the frequency
NFFT5 = 2 ^ nextpow2(N5);
Y5 = fft(y5, NFFT5) / N5;
f5 = (fs / 2 * linspace(0, 1, NFFT5 / 2+1))'; % Vector containing frequencies in Hz
amp5 = ( 2 * abs(Y5(1: NFFT5 / 2+1))); % Vector containing corresponding amplitudes
%subplot (212),
figure;
plot (f5, amp5);
title ('Single-sided amplitude spectrume for during onset of EMG7 signal')
xlabel ('frequency (Hz)')
ylabel ('|y(f)|')
grid on;