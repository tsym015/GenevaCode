fs = 150; %sampling rate should be at least 2x higher than max desired freq to measure
t = 0 : 1/fs : 5 - 1/fs; %increasing time increases resolution of sampled frequencies
f1 = 20;
f2 = 30;
f3 = 40;
f4 = 55;
L = length(t);
wave = 3*cos(2*pi*f1*t +0.2) + 1*cos(2*pi*f2*t - 0.3) ...
     + 2*cos(2*pi*f3*t +2.4) + 4*sin(2*pi*f4*t -0.8);

figure(1);
plot(t,wave);
title('Time Domain')

WAVE = fft(wave);
WAVE_mag = abs(WAVE(1:L/2+1));

HzAxis = (fs/2)*linspace(0,1,L/2+1);
figure(3);
plot(HzAxis,WAVE_mag);
title('Frequency Domain (Hz)')