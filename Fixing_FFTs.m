%Fixing no RF 5min growth 5.0e-3p 350C by dividing by MgO measured on same
%day. Calculate the FFT of AuMgO. Input its shifted position and signal. Set max
%freq to 150THz and freq. resolution to 0.1

[wGold,fdGold] = CalcTDSFFT(NoRF5min_2Shift,NoRF5min_2Signal,150,0.1);

%Calculate FFT of MgO. Input shifted position and signal.

[wMgO,fdMgO] = CalcTDSFFT(MgOShift,MgOSignal1,150,0.1);

%Fix the FFT of AuMgO by dividing every term in fdGold by every term in
%fdMgO. This will be a set of complex numbers

cmplxt = fdGold./fdMgO;

%Plot the real portion of this result, squaring every term. Do this by 
%multiplying by the complex conjugate. Plotting either wGold or wMgO will work

figure;
plot(wGold,cmplxt.*conj(cmplxt));
title('Fixed FFT AuMgO with MgO')
xlabel('wavenumber (cm-1)')
ylabel('amplitude')







%Windowing and Appodizing
%Starting with just AuMgO
[WindowGoldx,WindowGoldy] = WindowTDSData(NoRF5min_2Position,NoRF5min_2Signal,33.2086,0.7,2.5);
[Goldx_appodized, Goldy_appodized, Goldy_shift] = AppodizeTDSData(WindowGoldx,WindowGoldy,33.2086);
[Goldw, Goldfd] = CalcTDSFFT(Goldx_appodized, Goldy_appodized, 150, 0.1);

%Now doing MgO
[WindowMgOx,WindowMgOy] = WindowTDSData(MgOPosition1,MgOSignal1,32.9928,0.7,2.5);
[MgOx_appodized, MgOy_appodized, MgOy_shift] = AppodizeTDSData(WindowMgOx,WindowMgOy,32.9928);
[MgOw, MgOfd] = CalcTDSFFT(MgOx_appodized, MgOy_appodized, 150, 0.1);







%Checking to see that the windows are correctly plotted
figure;
subplot(2,1,1);
plot(Goldx_appodized, Goldy_appodized);
subplot(2,1,2);
plot(MgOx_appodized, MgOy_appodized);

%Everything checks out well.

%plotting FFT of Windowed/Appodized Gold fixed with MgO
cmplxtGoldMgO = Goldfd./MgOfd;
figure;
plot(Goldw, cmplxtGoldMgO.*conj(cmplxtGoldMgO));
title('Windowed and Appodized AuMgO Transmission fixed with MgO')
xlabel('wavenumber (cm-1)')
ylabel('amplitude')

%Plotting Gold Window/Appodized with no appodization overlayed
figure;
plot(Goldw, cmplxtGoldMgO.*conj(cmplxtGoldMgO),wGold,cmplxt.*conj(cmplxt));
title('Windowed and Appodized AuMgO Transmission fixed with MgO vs Not Windowed/Appodized');
xlabel('wavenumber (cm-1)');
ylabel('amplitude');

%The plot of the film and the MgO transmission divided by the MgO
%transmission is only helpful if the two pieces of MgO are exactly the same
%thickness. Since they are probably slightly different, we can measure the
%effect of the gold by instead taking the AuMgO film, dividing it by the
%transmission of just the hole, and comparing that result to the result of
%the MgO divided by the hole. 






%Windowing and appodizing hole
[WindowHolex,WindowHoley] = WindowTDSData(Hole_Nov15Position,Hole_Nov15Signal,32.2464,0.7,2.5);
[Holex_appodized, Holey_appodized, Holey_shift] = AppodizeTDSData(WindowHolex,WindowHoley,32.2464);
[Holew, Holefd] = CalcTDSFFT(Holex_appodized, Holey_appodized, 150, 0.1);








%Checking to see that hole and MgO windows are correctly plotted
subplot(2,1,1);
plot(Holex_appodized, Holey_appodized);
subplot(2,1,2);
plot(MgOx_appodized, MgOy_appodized);

%plotting FFT of Windowed/Appodized Gold fixed with Hole
cmplxtGoldHole = Goldfd./Holefd;
figure;
plot(Goldw, cmplxtGoldHole.*conj(cmplxtGoldHole));
title('Windowed and Appodized AuMgO Transmission fixed with Hole')
xlabel('wavenumber (cm-1)')
ylabel('amplitude')

%plotting FFT of Windowed/Appodized MgO fixed with Hole
cmplxtMgOHole = MgOfd./Holefd;
figure;
plot(MgOw, cmplxtMgOHole.*conj(cmplxtMgOHole));
title('Windowed and Appodized MgO Transmission fixed with Hole')
xlabel('wavenumber (cm-1)')
ylabel('amplitude')

%Overlaying these two plots
figure;
plot(Goldw, cmplxtGoldHole.*conj(cmplxtGoldHole), MgOw, cmplxtMgOHole.*conj(cmplxtMgOHole));
title('AuMgO fixed with hole vs. MgO fixed with hole');
xlabel('wavenumber (cm-1)')
ylabel('amplitude')
legend('Fixed AuMgO', 'Fixed MgO')









%Saving the windowed and appodized MgO/Hole and AuMgO/Hole FFT data
MgO_Hole_real(:,1) = MgOw;
MgO_Hole_real(:,2) = real(cmplxtMgOHole);

MgO_Hole_imag(:,1) = MgOw;
MgO_Hole_imag(:,2) = imag(cmplxtMgOHole);

save(sprintf('MgO_Hole_real.dat'),'MgO_Hole_real','-ascii');
save(sprintf('MgO_Hole_imag.dat'),'MgO_Hole_imag','-ascii');

AuMgO_Hole_real(:,1) = Goldw;
AuMgO_Hole_real(:,2) = real(cmplxtGoldHole);

AuMgO_Hole_imag(:,1) = Goldw;
AuMgO_Hole_imag(:,2) = imag(cmplxtGoldHole);

save(sprintf('AuMgO_Hole_real.dat'),'AuMgO_Hole_real','-ascii');
save(sprintf('AuMgO_Hole_imag.dat'),'AuMgO_Hole_imag','-ascii');











%Fixing MgO by dividing by Hole
%Calculate the FFT of MgO. Input MgO position and signal
%Set max frequency to 150THz and freq. resolution to 0.1

[wa,fda] = CalcTDSFFT(MgOPosition1,MgOSignal1,150,0.1);

%Calculate the FFT of the hole. Input hole position and signal

[wb,fdb] = CalcTDSFFT(HolePosition1,HoleSignal1,150,0.1);

%Fix the FFT of MgO by dividing every term in fda by every term in fdb
%This will be a set of complex numbers

cmplxt = fda./fdb;

%Plot the real portion of this result, squaring every term. Do this by 
%multiplying by the complex conjugate. Plotting either wa or wb will work

figure;
plot(wa,cmplxt.*conj(cmplxt));
title('Fixed FFT MgO with Hole')
xlabel('wavenumber (cm-1)')
ylabel('amplitude')







%Fixing AuThin by dividing by Hole

[wc,fdc] = CalcTDSFFT(AuPosition1,AuSignal1,150,0.1);

[wb,fdb] = CalcTDSFFT(HolePosition1,HoleSignal1,150,0.1);

cmplxt2 = fdc./fdb;

figure;
plot(wa,cmplxt2.*conj(cmplxt2));
title('Fixed FFT AuThin with Hole')
xlabel('wavenumber (cm-1)')
ylabel('amplitude')






%Fixing AuThick by dividing by Hole

[wd,fdd] = CalcTDSFFT(AuThickPosition1,AuThickSignal1,150,0.1);

[wb,fdb] = CalcTDSFFT(HolePosition1,HoleSignal1,150,0.1);

cmplxt3 = fdd./fdb;

figure;
plot(wa,cmplxt3.*conj(cmplxt3));
title('Fixed FFT AuThick with Hole')
xlabel('wavenumber (cm-1)')
ylabel('amplitude')




%Fixing AuThick by dividing by MgO

[wd,fdd] = CalcTDSFFT(AuThickPosition1,AuThickSignal1,150,0.1);

[wa,fda] = CalcTDSFFT(MgOPosition1,MgOSignal1,150,0.1);

cmplxt4 = fdd./fda;

figure;
plot(wa,cmplxt4.*conj(cmplxt4));
title('Fixed FFT AuThick with MgO')
xlabel('wavenumber (cm-1)')
ylabel('amplitude')




%Windowing and Appodizing
%Starting with just MgO
[WindowMgOx,WindowMgOy] = WindowTDSData(MgOPosition1,MgOSignal1,32.9948,1,2.5);
[MgOx_appodized, MgOy_appodized, MgOy_shift] = AppodizeTDSData(WindowMgOx,WindowMgOy,32.9948);
[MgOw, MgOfd] = CalcTDSFFT(MgOx_appodized, MgOy_appodized, 150, 0.1);

%Now doing hole
[WindowHolex,WindowHoley] = WindowTDSData(HolePosition1,HoleSignal1,31.9006,1,2.5);
[Holex_appodized, Holey_appodized, Holey_shift] = AppodizeTDSData(WindowHolex,WindowHoley,32.9948);
[Holew, Holefd] = CalcTDSFFT(Holex_appodized, Holey_appodized, 150, 0.1);

%Checking to see that the windows are correctly plotted
figure;
subplot(2,1,1);
plot(MgOx_appodized, MgOy_appodized);
subplot(2,1,2);
plot(Holex_appodized, Holey_appodized);

%Now doing Thick Gold
[WindowAuThickx,WindowAuThicky] = WindowTDSData(AuThickPosition1,AuThickSignal1,32.9701,1,2.5);
[AuThickx_appodized, AuThicky_appodized, AuThicky_shift] = AppodizeTDSData(WindowAuThickx,WindowAuThicky,32.9948);
[AuThickw, AuThickfd] = CalcTDSFFT(AuThickx_appodized, AuThicky_appodized, 150, 0.1);


%plotting FFT of Windowed/Appodized MgO fixed with Hole
cmplxtMgOHole = MgOfd./Holefd;
figure;
plot(MgOw, cmplxtMgOHole.*conj(cmplxtMgOHole));
title('Windowed and Appodized MgO Transmission fixed with Hole')
xlabel('wavenumber (cm-1)')
ylabel('amplitude')

%plotting FFT of Windowed/Appodized AuThick fixed with Hole
cmplxtAuThickHole = AuThickfd./Holefd;
figure;
plot(AuThickw, cmplxtAuThickHole.*conj(cmplxtAuThickHole));
title('Windowed and Appodized AuThick Transmission fixed with Hole')
xlabel('wavenumber (cm-1)')
ylabel('amplitude')

%Plotting MgO Window/Appodized with no appodization overlayed
cmplxtMgOHole = MgOfd./Holefd;
[wa,fda] = CalcTDSFFT(MgOPosition1,MgOSignal1,150,0.1);
[wb,fdb] = CalcTDSFFT(HolePosition1,HoleSignal1,150,0.1);
cmplxt = fda./fdb;
figure;
plot(MgOw, cmplxtMgOHole.*conj(cmplxtMgOHole),wa,cmplxt.*conj(cmplxt));
title('Windowed and Appodized MgO Transmission fixed with Hole vs Not Windowed/Appodized');
xlabel('wavenumber (cm-1)');
ylabel('amplitude');





%Saving real and imaginary components of data frames

%Saving the windowed and appodized MgO/Hole FFT data
MgO_Hole_real(:,1) = MgOw;
MgO_Hole_real(:,2) = real(cmplxtMgOHole);

MgO_Hole_imag(:,1) = MgOw;
MgO_Hole_imag(:,2) = imag(cmplxtMgOHole);

save(sprintf('MgO_Hole_real.dat'),'MgO_Hole_real','-ascii');
save(sprintf('MgO_Hole_imag.dat'),'MgO_Hole_imag','-ascii');















