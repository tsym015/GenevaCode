%Plotting two different measurements for hole

figure;
plot(HolePosition1,HoleSignal1,Hole_Nov15Position,Hole_Nov15Signal);







%Hole
Hole300K1 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/Hole_300K/Hole_300K_1.csv');
HolePosition1 = Hole300K1(:, 1);
HoleSignal1 = Hole300K1(:, 2);
HoleFreqWN1 = Hole300K1(:, 3);
HolePhase1 = Hole300K1(:, 6);

HoleShift = HolePosition1 - 30.4039;
HoleScale = HoleSignal1 / 5260.82;

%MgO
MgO300K1 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/MgO_300K/MgO_300K 001.csv');
MgOPosition1 = MgO300K1(:, 1);
MgOSignal1 = MgO300K1(:, 2);
MgOFreqWN1 = MgO300K1(:, 3);
MgOFFT1 = MgO300K1(:, 4);
MgOPhase1 = MgO300K1(:, 6);

MgOShift = MgOPosition1 - 31.4982;
MgOScale = MgOSignal1 / 3531.96;

figure;
plot(MgOPosition1,MgOSignal1);
title('MgO Transmission Signal');
xlabel('Delay Line Position (mm)');
ylabel('Signal');

%AuThin
Au300K1 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/Au_300K/Au_300K 001.csv');
AuPosition1 = Au300K1(:, 1);
AuSignal1 = Au300K1(:, 2);
AuFreqWN1 = Au300K1(:, 3);
AuFFT1 = Au300K1(:, 4);
AuPhase1 = Au300K1(:, 6);

AuShift = AuPosition1 - 31.4832;
AuScale = AuSignal1 / 3408.9;

figure;
plot(AuPosition1,AuSignal1,'r');
title('MgO With Thin Au Transmission Signal');
xlabel('Delay Line Position (mm)');
ylabel('Signal');

%AuThick
AuThick300K1 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuThick_300K/AuThick_300K 001.csv');
AuThickPosition1 = AuThick300K1(:, 1);
AuThickSignal1 = AuThick300K1(:, 2);
AuThickFreqWN1 = AuThick300K1(:, 3);
AuThickFFT1 = AuThick300K1(:, 4);
AuThickPhase1 = AuThick300K1(:, 6);

AuThickShift = AuThickPosition1 - 31.4832;
AuThickScale = AuThickSignal1 / 12.4347;

figure;
plot(AuThickPosition1,AuThickSignal1,'m');
title('MgO With Thick Au Transmission Signal');
xlabel('Delay Line Position (mm)');
ylabel('Signal');

% %Plotting all four tests aligned and scaled 
% figure
% plot(HoleShift, HoleScale, 'b', ...
%     MgOShift, MgOScale, 'r', ...
%     AuShift, AuScale, 'g', ...
%     AuThickShift, AuThickScale, 'm', ...
%     'LineWidth', 1.2);
% xlabel('Position (from start)');
% ylabel('Signal (scaled)');
% legend('Hole 300K', 'MgO 300K', 'Thin Au 300K', 'Thick Au 300K');
% title('Scaled and Aligned Tests');
% 
% %Plotting Thick and Thin Gold aligned and scaled
% figure
% plot(AuShift, AuScale, 'b', ...
%     AuThickShift, AuThickScale, 'r', ...
%     'LineWidth', 1.2);
% xlabel('Position (from start)');
% ylabel('Signal (scaled)');
% legend = legend('Thin Au 300K', 'Thick Au 300K');
% legend.FontSize = 14;
% title('Scaled and Aligned Gold Tests');



%Plotting Hole, MgO, and thin Au (aligned)
figure
plot(HoleShift, HoleSignal1, 'b', ...
    MgOShift, MgOSignal1, 'r', ...
    AuShift, AuSignal1, 'g', ...
    'LineWidth', 1.2);
xlabel('Position');
ylabel('Signal');
legend = legend('Hole 300K', 'MgO 300K', 'Au 300K');
legend.FontSize = 14;
title('empty, substrate, and gold overlay');

%Plotting Hole, MgO, and thin Au with time x-axis
figure
c = 2.99792458e11;
pico = 1.0e12;
plot(HoleShift/c*pico, HoleSignal1, 'b', ...
    MgOShift/c*pico, MgOSignal1, 'r', ...
    AuShift/c*pico, AuSignal1, 'g', ...
    'LineWidth', 1.2);
xlabel('Time (picoseconds)');
ylabel('Signal');
legend = legend('Hole 300K', 'MgO 300K', 'Au 300K');
legend.FontSize = 14;
title('empty, substrate, and gold overlay (time domain)')




%Plotting Thick Au
figure
plot(AuThickPosition1,AuThickSignal1)
title('Thick Gold Film Position Domain')



%plotting the machine calculated FFT
figure
subplot(2,1,1)
plot(AuThickFFT1)
title('Machine FFT AuThick')

clear


%Plotting hole and MgO from 15.11.17 to check on the THz signal... it seems
%to be asymmetrical which could be an issue. 

Hole_Nov15300K = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/Hole_300K/Hole_15.11.17.csv');
Hole_Nov15Position = Hole_Nov15300K(:, 1);
Hole_Nov15Signal = Hole_Nov15300K(:, 2);
Hole_Nov15FreqWN = Hole_Nov15300K(:, 3);
Hole_Nov15Phase = Hole_Nov15300K(:, 6);
Hole_Nov15Shift = Hole_Nov15Position - 32.2464;

MgO300K1 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/MgO_300K/Nov.15MgO_forP5.0/MgO_15.11.17.csv');
MgOPosition1 = MgO300K1(:, 1);
MgOSignal1 = MgO300K1(:, 2);
MgOFreqWN1 = MgO300K1(:, 3);
MgOFFT1 = MgO300K1(:, 4);
MgOPhase1 = MgO300K1(:, 6);
MgOShift = MgOPosition1 - 32.9928;

figure;
plot(MgOShift,MgOSignal1,Hole_Nov15Shift,Hole_Nov15Signal);
title('Hole and MgO at 300K)')
xlabel('Position');
ylabel('Signal');
legend('MgO', 'Hole');





