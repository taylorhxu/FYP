% import iile
file = 'freq.xlsx';
frequency = importdata(file);
a = frequency.data;
% column 1 in excel sheet, time
fX=frequency.data(:,1);
% column 5 in excel sheet, the gain
fY=frequency.data(:,5);

plot(fX,fY);
xlabel('Frequency (Hz)');ylabel('Gain(dB)');title('Signal Magnitude Response')
