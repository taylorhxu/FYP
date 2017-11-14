function y = DWT2(x, sampling_rate, scale_level)
%
%  y = DWT2(x, sampling_rate, scale_level)
%
%  DWT2 produces the discrete wavelet Haar transform of "x", for
%  the number of "scale-levels" indicated.  The length of "x" is
%  expected to be a power of 2; otherwise, it is zero padded to the
%  next power of 2 greater than the length of "x".  "Sampling_rate"
%  is the time increment between samples in seconds.  The output image
%  is normalized to show the high frequencies.
%

if (nargin ~= 3)
        disp('DWT2 requires 3 input arguments!')
	return;
end
if ((scale_level < 1) | (round(scale_level) ~= scale_level))
	disp('The argument "scale_level" must be an integer greater than 0.');
	return;
end
if (sampling_rate <= 0)
	disp('The argument "sampling_rate" must be greater than 0.');
	return;
end

[m,n] = size(x);
if (m ~= 1)
	X = x';
else
	X = x;
end
[m,n] = size(X);
if (m ~= 1)
	disp('X must be a vector, not a matrix!');
	return;
end

LENX = length(X);
PAD = 2^(ceil(log2(LENX))) - LENX;
XX = [X zeros(1,PAD)];
LENXX = length(XX);

if (scale_level > log2(LENXX))
	disp('The argument "scale_level" is too large.');
	return;
end

SL = 2^scale_level;
SLT = SL;
y = zeros((LENXX/2),SL);
y_img = zeros((LENXX/2),SL);

h0 = [sqrt(2)/2 sqrt(2)/2];
h1 = [-sqrt(2)/2 sqrt(2)/2];

TY = [];
c = XX;
for jj = 1:1:scale_level
	L = length(c);
	d = conv(c, h1);
	d = d(1:2:L);
	c = conv(c,h0);
	c = c(1:2:L);
	TY = [d TY];
end
TY = [c TY];

TY = fliplr(TY);
ST = 1;		COL = SL;
for kk = 1:1:(scale_level+1)

% CHOP UP DATA VECTOR FROM TY INTO T3, ITERATIVELY.

	SLT = SLT/2;
	SP = 2^(kk-1);
	SA = LENXX/(SP*2);
	T3 = zeros(1,(LENXX/2));
	if (kk ~= (scale_level+1))
		T3(1:SP:(LENXX/2)) = TY(ST:1:(ST+SA-1));
		ST = ST + SA;
	else
		SLT = SLT*2;
		SP = SP/2;
		T3(1:SP:(LENXX/2)) = TY(ST:1:LENXX);
	end

% SHIFT AND COPY T3 TO FILL IN TIME SLOTS AT LOWER FREQUENCIES.

	for nn = 2:1:SP
		T2 = [zeros(1,(nn-1)) T3];	T2 = T2(1:1:LENXX/2);
		T3 = T3 + T2;
	end

% NORMALIZE T3
	
	T3 = abs(T3)/max(abs(T3));

% REPEAT T3 VECTOR TO FILL IN FREQUENCY SLOTS IN MATRIX "y".

	for mm = SLT:-1:1
		y(:,COL) = T3';
		y_img(:,COL) = T3';
		COL = COL - 1;
	end
end

y = flipud(y);
y_img = flipud(y_img);

freq = (1/sampling_rate)/2;
imagesc([0:sampling_rate*2:(sampling_rate*(LENXX-1))],[0 (freq/(SL-1))*[1:1:(SL-1)]],(y_img').^2);
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');
axis([0 (sampling_rate*LENXX) 0 freq]);
axis('xy')

