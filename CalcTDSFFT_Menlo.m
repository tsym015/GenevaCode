function [wFFT_Matlab, yFFT_Matlab] = CalcTDSFFT_Menlo(x,y,max_freq,freq_res)
    
    % Inputs:
    % x - time vector in psec - either 1 column vector or matrix where each
    % column is different spectra.
    % y - TDS signal (a.u.) - either 1 column vector or matrix where each
    % column is different spectra.
    % freq_res - required resolution in cm^-1. function will use number
    % of points (in power of 2 for accelerating FFT process) which will
    % give better resolution than required
    % 
    % Outputs:
    % w_cm - frequency vector (or matrix) in cm^-1 according to resolution
    % set by number of points (defined by power of 2)
    % yFFT - complex vector (or matrix) of the TDS signal.
    
    tic;
    [nRows, nCols] = size(y);
    Ts = mean(diff(x)); % sampling time in ps
    c_light_cm = 2.99792458e10;
    psec_units = 1e-12;
    Fs_user(1:length(Ts)) = freq_res*c_light_cm*psec_units; % required sampling frequency in THz
    NFFT_user = 1./(Fs_user.*Ts); % number of points to achieve required sampling frequency
    
    NFFT_user = 2.^nextpow2(NFFT_user); % n power law for FFT
    NFFT_data(1:nCols) = 2.^nextpow2(length(y)); 

    if NFFT_user > NFFT_data
        NFFT = mean(NFFT_user);
    else
        NFFT = mean(NFFT_data);
    end;
    
    Fs = 1./Ts; % sampling frequency in THz
    Fs_cm = Fs/c_light_cm/psec_units; % sampling frequency step in cm^-1
    
    wFFT_Matlab = (0:NFFT/2-1)'*(Fs_cm/NFFT); % in cm^-1

    yFFT_Matlab = ifft(y,NFFT,1);
        
    yFFT_Matlab = yFFT_Matlab(1:NFFT/2,:); % Take the single sided spectra
    
    yFFT_Matlab(2:end-1,:) = 2*yFFT_Matlab(2:end-1,:); % Conserves the spectral weight
    
    max_ind = int16(max_freq*NFFT/Fs_cm)+1;
    wFFT_Matlab = wFFT_Matlab(1:max_ind,:);
    yFFT_Matlab = yFFT_Matlab(1:max_ind,:);
    
    toc;
end
