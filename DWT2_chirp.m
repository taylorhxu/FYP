chirp;

x = chirp';
sampling_rate = 1;

clf;
subplot(4,2,1)
plot(x);
xlabel('Time (seconds)');
title('Oringinal Signal');
axis([0 256 -1 1]);

subplot(4,2,2)
scale_level =  1;
y = DWT2(x, sampling_rate, scale_level);
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');
title('Scale Level = 1');

subplot(4,2,3)
scale_level =  2;
y = DWT2(x, sampling_rate, scale_level);
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');
title('Scale Level = 2');

subplot(4,2,4)
scale_level =  3;
y = DWT2(x, sampling_rate, scale_level);
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');
title('Scale Level = 3');

subplot(4,2,5)
scale_level =  4;
y = DWT2(x, sampling_rate, scale_level);
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');
title('Scale Level = 4');

subplot(4,2,6)
scale_level =  5;
y = DWT2(x, sampling_rate, scale_level);
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');
title('Scale Level = 5');

subplot(4,2,7)
scale_level =  6;
y = DWT2(x, sampling_rate, scale_level);
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');
title('Scale Level = 6');

subplot(4,2,8)
scale_level =  7;
y = DWT2(x, sampling_rate, scale_level);
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');
title('Scale Level = 7');
