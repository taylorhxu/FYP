% Project 2
% Time-Frequency Representations
% Andy Doran
% 
% function coeffs = cwvt(sigin,scale,quiet)
%
% sigin  = sampled input signal (Should be a row vector)
% scale  = number of real, positive scale you want (1:scales)
% quiet  = plot suppression
%          1 -> suppress all plots
%          2 -> suppress wavelet plots only
%          3 -> suppress scalogram only
% coeffs = scales-by-length(sigin) matrix returning CWT of sigin at
%          each scale from 1 to scale
%
% This function takes an input signal and computes the Continuous Wavelet
% Transform at different scales using a sampled Morlet Wavelet
%
% Morelet Wavelet w(t) = (1/sigma*K)*exp-((sigma*t)^2)*cos(2*pi*fo*t)

function coeffs = cwvt(sigin,scale,quiet)

sigma = 0.05;    % Morlet Wavelet bandwidth
fo = 0.2;        % Center frequency of Wavelet
K = 1;           % Not sure what this is, so set to 1

M = length(sigin);
coeffs = zeros(scale,M);

for k=1:scale,
    t=(-M/2:M/2-1);

    % Calculate Morelet Wavelet w=e-(at^2)*cos(2*pi*fo*t)
    const = 1/(sigma*K*sqrt(k));
    e = exp(-((sigma*t/k).^2));
    phase = cos(2*pi*fo*t/k);
    w = const*e.*phase;

    % Plot wavelet in time domain and frequency domain
    if ((quiet ~= 1) & (quiet ~= 2))
      figure(3)
      if (k == 1)  % Clear plot on initial run-through
        clf
      end
      subplot(3,2,(2*k)-1)
      plot(w)
      txt = ['Morlet Wavelet at scale ', num2str(k)];
      title(txt)
      %figure(4)
      %if (k == 1)  % Clear plot on initial run-through
      %  clf
      %end
      subplot(3,2,2*k)
      plot(abs(fft(w)))
      txt = ['Frequency Spectra of Morlet Wavelet at scale ', num2str(k)];
      title(txt)
   end
    % Calculate CWT of sigin using circular convolution
    coeffs(k,:)=ifft(fft(w).*fft(sigin));
end

% Coeffs should be real anyway, this just accounts for numerical error
% in circular convolution that may give small imaginary parts
coeffs = real(coeffs);

% Plot scalogram and check against MATLAB's CWT routine
if ((quiet ~= 1) & (quiet ~= 3))
  figure(1)
  clf
  imagesc(coeffs);
  axis xy;
  txt = ['|C(t,s)| for s = 1 to ' num2str(scale)];
  title(txt)
  ylabel('s')
  xlabel('t')
  figure(2)
  clf
  cwt(sigin,1:scale,'morl','plot');  % Call MATLAB's CWT routine
  title('CWT Output from MATLAB')
end
