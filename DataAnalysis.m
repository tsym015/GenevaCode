%Final Film, grown for 4:38, 350C, 5.0p, 50W, no bias. Using Silver paint
%data, hole data, MgO data.

film = AuMgON2300KSilverPaint;
hole = HoleN2300K;
MgO = MgON2300K;

figure;
plot(film(:,3),film(:,2));
hold on;
plot(hole(:,3),hole(:,2));
hold on;
plot(MgO(:,3),MgO(:,2));
legend('film', 'hole', 'MgO')




%Plotting the transmission signal in the time domain for a 5min film
%grown with RF bias at 400C vs. the MgO by itself. The two plots are almost exactly
%identical, which indicates that the film is too thin. 

FiveMin = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/RF_bias/5min_400C_scan_3/5min400C_Teraview_3.csv');
FiveMinPosition = FiveMin(:, 1);
FiveMinSignal = FiveMin(:, 2);
FiveMinHoleFreqWN = FiveMin(:, 3);
FiveMinHolePhase = FiveMin(:, 6);
FiveMinShift = FiveMinPosition - 31.455;

MgO300K1 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/MgO_300K/MgO_300K 001.csv');
MgOPosition1 = MgO300K1(:, 1);
MgOSignal1 = MgO300K1(:, 2);
MgOFreqWN1 = MgO300K1(:, 3);
MgOFFT1 = MgO300K1(:, 4);
MgOPhase1 = MgO300K1(:, 6);
MgOShift = MgOPosition1 - 31.4982;

figure;
plot(MgOShift,MgOSignal1,FiveMinShift,FiveMinSignal);
title('5Min400C AuMgo and MgO at 300K')
xlabel('Position');
ylabel('Signal');
legend('MgO', '5Min400C');

clear

%plotting the transmission signal in the time domain for a 10min film grown
%with RF bias at 400C. The thickness of this film was measured to be 146+/-10nm, so
%it should certainly be thick enough to attenuate the THz signal and flip
%the second peak. However, the plot of the signal once again matches up
%almost perfectly with the MgO plot. This probably means that our film is
%junky, likley do to some effect of the RF bias.

TenMin = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/RF_bias/10min_400C_THz/10min400C_300k_SilverPaint.csv');
TenMinPosition = TenMin(:, 1);
TenMinSignal = TenMin(:, 2);
TenMinHoleFreqWN = TenMin(:, 3);
TenMinHolePhase = TenMin(:, 6);
TenMinShift = TenMinPosition - 31.49;

MgO300K1 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/MgO_300K/MgO_300K 001.csv');
MgOPosition1 = MgO300K1(:, 1);
MgOSignal1 = MgO300K1(:, 2);
MgOFreqWN1 = MgO300K1(:, 3);
MgOFFT1 = MgO300K1(:, 4);
MgOPhase1 = MgO300K1(:, 6);
MgOShift = MgOPosition1 - 31.4982;

figure;
plot(MgOShift,MgOSignal1,TenMinShift,TenMinSignal);
title('10Min400C AuMgO and MgO at 300K')
xlabel('Position');
ylabel('Signal');
legend('MgO', '10Min400C');


%Plotting the transmission signal in the time domain for a 5min growth
%grown without RF bias at 350C. Grown at a p=2.5x10e-3

NoRF5min = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/No_RF_bias/5min_350C_2.5mbar/5min350C_2.5mbar.csv');
NoRF5minPosition = NoRF5min(:, 1);
NoRF5minSignal = NoRF5min(:, 2);
NoRF5minHoleFreqWN = NoRF5min(:, 3);
NoRF5minHolePhase = NoRF5min(:, 6);
NoRF5minShift = NoRF5minPosition - 31.4432;

MgO300K1 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/MgO_300K/Nov.14MgO/MgO_14.11.17.csv');
MgOPosition1 = MgO300K1(:, 1);
MgOSignal1 = MgO300K1(:, 2);
MgOFreqWN1 = MgO300K1(:, 3);
MgOFFT1 = MgO300K1(:, 4);
MgOPhase1 = MgO300K1(:, 6);
MgOShift = MgOPosition1 - 31.7977;

figure;
plot(MgOShift,MgOSignal1,NoRF5minShift,NoRF5minSignal);
title('5Min350C (p=2.5) AuMgO and MgO at 300K (no RF bias)')
xlabel('Position');
ylabel('Signal');
legend('MgO', '5Min350C');


%Plotting the transmission signal in the time domain for a 5min growth
%grown without RF bias at 350C. Grown at a p=5.0x10e-3

NoRF5min_2 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/No_RF_bias/5min_350C_5.0mbar/5min350C_5.0p.csv');
NoRF5min_2Position = NoRF5min_2(:, 1);
NoRF5min_2Signal = NoRF5min_2(:, 2);
NoRF5min_2HoleFreqWN = NoRF5min_2(:, 3);
NoRF5min_2HolePhase = NoRF5min_2(:, 6);
NoRF5min_2Shift = NoRF5min_2Position - 33.2086;

MgO300K1 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/MgO_300K/Nov.15MgO_forP5.0/MgO_15.11.17.csv');
MgOPosition1 = MgO300K1(:, 1);
MgOSignal1 = MgO300K1(:, 2);
MgOFreqWN1 = MgO300K1(:, 3);
MgOFFT1 = MgO300K1(:, 4);
MgOPhase1 = MgO300K1(:, 6);
MgOShift = MgOPosition1 - 32.9928;

figure;
plot(MgOPosition1, MgOSignal1, Hole_Nov15Position, Hole_Nov15Signal);

figure;
plot(MgOShift,MgOSignal1,NoRF5min_2Shift,NoRF5min_2Signal);
title('5Min350C (p=5.0) AuMgO and MgO at 300K (no RF bias)')
xlabel('Position');
ylabel('Signal');
legend('MgO', '5Min350C');

%10min growth, no bias, 5.0p, 350C. Large signal attenuation.

NoRF10min = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/No_RF_bias/10min_350C_5.0mbar/10min_5.0p_300K.csv');
NoRF10minPosition = NoRF10min(:, 1);
NoRF10minSignal = NoRF10min(:, 2);
NoRF10minHoleFreqWN = NoRF10min(:, 3);
NoRF10minHolePhase = NoRF10min(:, 6);

figure;
plot(MgOPosition1, MgOSignal1, NoRF10minPosition, NoRF10minSignal);

%5min growth, no bias, 8.5p, 350C. 

NoRF5min8p = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/No_RF_bias/5min_350C_8.5mbar/5min350C_8.5mbar.csv');
NoRF5min8pPosition = NoRF5min8p(:, 1);
NoRF5min8pSignal = NoRF5min8p(:, 2);
NoRF5min8pHoleFreqWN = NoRF5min8p(:, 3);
NoRF5min8pHolePhase = NoRF5min8p(:, 6);


figure;
plot(MgOPosition1, MgOSignal1, NoRF5min8pPosition, NoRF5min8pSignal);
















