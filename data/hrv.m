file = 'WS18.lvm';
ecg = importdata(file,'\t',23);
a=ecg.data;
ecgX=ecg.data(:,1);
ecgY=ecg.data(:,2);


%% HRV
[pks, loc, w, p] = findpeaks(ecgY,ecgX, 'MinPeakProminence', 0.0035);
figure(1)
plot(ecgX,ecgY, 'k',loc,pks,'rd')
RR = diff(loc);
Time_Interval = loc;
Time_delay = diff(Time_Interval);
set(gca, 'Xlim', [300,305]) 
xlabel('Seconds'); ylabel('Amplitude'); legend('Real Time ECG signal')
grid on
title('Heart Rate Variability')


%% RR
figure(2)
plot(RR)
xlabel('Time'); ylabel('Amplitude')
%%set(gca, 'Ylim', [0,2]) 
title('Graph of R-R Interval against Time')

%% Histogram
figure(3)
histogram(RR,5)
xlabel('Time');ylabel('No. of Samples')
grid on
title('Histogram of R-R Interval')

%% Poincare plot
t=-pi:0.01:pi;
orientation = pi/4;
figure(4)
RR1 = RR(1:end-1);
RR2 = RR(2:end);
MIDx = median(RR1);
MIDy = median(RR2);
std1 = std(RR1-RR2)/sqrt(2);
std2 = std(RR1+RR2)/sqrt(2);
plot(RR1, RR2,'ro', MIDx, MIDy, 'kx'); 
xlabel('RR_n (s)');ylabel(('RR_n_+_1 (s)'))
hold on
x=MIDx+std2*cos(t);
y=MIDy+std1*sin(t);
xx_P = (x-MIDx)*cos(orientation) - (y-MIDy)*sin(orientation) + MIDx;
yy_P = (x-MIDx)*sin(orientation) + (y-MIDy)*cos(orientation) + MIDy;
plot(xx_P,yy_P,'LineWidth', 2,'Color', [1,0,0])
axis equal
hold on;
dist = std2/sqrt(2);
x1 = MIDx + dist;
y1 = MIDy + dist;
x2 = MIDx - dist;
y2 = MIDy - dist;
dist2 = std1/sqrt(2);
x3 = MIDx + dist2;
y3 = MIDy + dist2;
x4 = MIDx - dist2;
y4 = MIDy - dist2;
line([x1, x2], [y1, y2], 'LineWidth', 1, 'Color', [0,1,1]);
line([x3, x4], [y4, y3], 'LineWidth', 1, 'Color', [0,0,0]);
hold on
plot(MIDx,MIDy,'rh','MarkerFaceColor','r');
title('Poincare plot, SD1 = 0.2392, SD2 = 0.2679')

%% Spline
z = spline (loc, pks, ecgX);

figure
plot (loc, pks, 'ro', ecgX, z, 'b')

%% SDNN = 0.2543 (Standard deviation of all NN intervals)
SDNN = std(RR)

%% RMSSD = 0.9364 (Square root of the mean of the squares of differences between adjacent NN intervals)
RMSSD = sqrt((sum((RR).^2))/size(loc,1))

%% pNN50(%) = 19.0726 (Percentage of differences between adjacent NN intervals that are greater than 50 ms)
successive_NNs = diff(RR);
NN50 = successive_NNs>0.050;
pNN50 = ((sum(NN50))/size(RR,1))*100

%% Heart Rate = 66.5175
Minutes =  max(ecgX)/60;
Beats_Per_Minute_Prominence = ((size(RR,1))/Minutes)

%% Total Power (PT)
PT = bandpower(z,1000, [0 0.4]);

%% Power in low frequency range (PLF)
PLF= bandpower(z, 1000, [0.04 0.15]);

%% Power in high frequency range (PHF)
PHF = bandpower(z, 1000, [0.15 0.4]);

%% Ratio of power in low to high frequency range (PLF/PHF)
Ratio = PLF/PHF