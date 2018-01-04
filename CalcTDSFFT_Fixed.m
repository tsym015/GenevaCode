function [FD_outputFixed] = CalcTDSFFT_Fixed(xa, xb, ya, yb, max_freq,freq_res)

% convert TeraView Time Domain Spectrum to Frequency Domain 
% Inputs:
% Delay line position x in mm
% Time Domain signal y in arb. units
% Desired max frequency in cm^-1
% Desired resolution in cm^-1
%
% Outputs:
% Frequency vector in cm^-1
% Frequency domain signal (complex number)
tic;
xa_FFT = 2*xa/10;

xb_FFT = 2*xb/10;


deltaxa = (diff(xa_FFT(2:end))+diff(xa_FFT(1:end-1)))/2;
deltaxa = vertcat(deltaxa(1)/2,deltaxa,deltaxa(end)/2);

deltaxb = (diff(xb_FFT(2:end))+diff(xb_FFT(1:end-1)))/2;
deltaxb = vertcat(deltaxb(1)/2,deltaxb,deltaxb(end)/2);


w = (0:freq_res:max_freq);


FD_outputa = sum(repmat(ya,1,length(w)).*repmat(deltaxa,1,length(w)).*exp(1i*2*pi*repmat(w,length(xa_FFT),1).*repmat(xa_FFT,1,length(w))));
FD_outputb = sum(repmat(yb,1,length(w)).*repmat(deltaxb,1,length(w)).*exp(1i*2*pi*repmat(w,length(xb_FFT),1).*repmat(xb_FFT,1,length(w))));

FD_outputFixed = FD_outputa / FD_outputb;


toc;
end
