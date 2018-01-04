function [wFFT_manual, yFFT_manual] = CalcTDSFFT_Menlo_New(x,y,max_freq,freq_res)

% convert Time Domain Spectrum of Menlo system to Frequency Domain 
% Inputs:
% Delay line x in time [psec] 
% Time Domain signal y in arb. units
% Desired max frequency in cm^-1
% Desired resolution in cm^-1
%
% Outputs:
% Frequency vector in cm^-1
% Frequency domain signal (complex number)
tic;

c_light_cm = 2.99792458e10;
psec_unit = 1e-12;
x_FFT = (x * c_light_cm * psec_unit);

deltax = (diff(x_FFT(2:end))+diff(x_FFT(1:end-1)))/2;
deltax = vertcat(deltax(1)/2,deltax,deltax(end)/2);

wFFT_manual = (0:freq_res:max_freq);

yFFT_manual = sum(repmat(y,1,length(wFFT_manual)).*repmat(deltax,1,length(wFFT_manual)).*exp(1i*2*pi*repmat(wFFT_manual,length(x_FFT),1).*repmat(x_FFT,1,length(wFFT_manual))));

toc;
end
