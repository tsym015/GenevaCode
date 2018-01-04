
NoRF5min_2 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/No_RF_bias/5min_350C_5.0mbar/5min350C_5.0p.csv');
NoRF5min_2Position = NoRF5min_2(:, 1);
NoRF5min_2Signal = NoRF5min_2(:, 2);

MgO300K1 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/MgO_300K/Nov.15MgO_forP5.0/MgO_15.11.17.csv');
MgOPosition1 = MgO300K1(:, 1);
MgOSignal1 = MgO300K1(:, 2);

Hole_Nov15300K = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/Hole_300K/Hole_15.11.17.csv');
Hole_Nov15Position = Hole_Nov15300K(:, 1);
Hole_Nov15Signal = Hole_Nov15300K(:, 2);

%Hole from several weeks prior
Hole300K1 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/Hole_300K/Hole_300K_1.csv');
HolePosition1 = Hole300K1(:, 1);
HoleSignal1 = Hole300K1(:, 2);


%Windowing and Appodizing to select for the entire signal (to compare with
%data from Rowan)

%check to see how far the window can go without going past the data on each
%side
figure;
plot(HolePosition1,HoleSignal1,MgOPosition1,MgOSignal1);


%Starting with just AuMgO
[WindowGoldx,WindowGoldy] = WindowTDSData(NoRF5min_2Position,NoRF5min_2Signal,33.2086,0.7,4.7);
[Goldx_appodized, Goldy_appodized, Goldy_shift] = AppodizeTDSData(WindowGoldx,WindowGoldy,33.2086);
[Goldw, Goldfd] = CalcTDSFFT(Goldx_appodized, Goldy_appodized, 100, 0.1);

%Now doing MgO
[WindowMgOx,WindowMgOy] = WindowTDSData(MgOPosition1,MgOSignal1,32.9928,0.7,4.8);
[MgOx_appodized, MgOy_appodized, MgOy_shift] = AppodizeTDSData(WindowMgOx,WindowMgOy,32.9928);
[MgOw, MgOfd] = CalcTDSFFT(MgOx_appodized, MgOy_appodized, 100, 0.1);

%Windowing and appodizing hole
[WindowHolex,WindowHoley] = WindowTDSData(HolePosition1,HoleSignal1,31.9006,1.3,4.3);
[Holex_appodized, Holey_appodized, Holey_shift] = AppodizeTDSData(WindowHolex,WindowHoley,31.9006);
[Holew, Holefd] = CalcTDSFFT(Holex_appodized, Holey_appodized, 100, 0.1);

cmplxtMgOHole = MgOfd./Holefd;




%Saving the windowed and appodized MgO/Hole and AuMgO/Hole FFT data
MgO_Hole_real(:,1) = MgOw;
MgO_Hole_real(:,2) = real(cmplxtMgOHole);

MgO_Hole_imag(:,1) = MgOw;
MgO_Hole_imag(:,2) = imag(cmplxtMgOHole);

save(sprintf('MgO_Hole_Fullreal.dat'),'MgO_Hole_real','-ascii');
save(sprintf('MgO_Hole_Fullimag.dat'),'MgO_Hole_imag','-ascii');

AuMgO_Hole_real(:,1) = Goldw;
AuMgO_Hole_real(:,2) = real(cmplxtGoldHole);

AuMgO_Hole_imag(:,1) = Goldw;
AuMgO_Hole_imag(:,2) = imag(cmplxtGoldHole);

save(sprintf('AuMgO_Hole_Fullreal.dat'),'AuMgO_Hole_real','-ascii');
save(sprintf('AuMgO_Hole_Fullimag.dat'),'AuMgO_Hole_imag','-ascii');










%Comparing my data to Rowan's data
RowanW = fullreal1(:,1);
RowanReal = fullreal1(:,2);
RowanImag = fullimag1(:,2);

MyW = MgOw;
MyReal = real(cmplxtMgOHole);
MyImag = imag(cmplxtMgOHole);

figure;
plot(MyW,MyReal,RowanW,RowanReal);
title('My real data vs. Rowan real data');
legend('Mine', 'Rowan');

figure;
plot(RowanW,RowanImag,MyW,MyImag);
title('Rowan imag vs. My imag data')
legend('Rowan', 'Mine');












