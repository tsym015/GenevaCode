
HolePosition = Position_to_Time_Menlo(HoleN2300K(:, 3));
HoleSignal = HoleN2300K(:, 2);

MgOPosition = Position_to_Time_Menlo(MgON2300K(:, 3));
MgOSignal = MgON2300K(:, 2);

FilmPosition = Position_to_Time_Menlo(AuMgON2300KSilverPaint(:, 3));
FilmSignal = AuMgON2300KSilverPaint(:, 2);

figure;
plot(HolePosition,HoleSignal,MgOPosition,MgOSignal);

%Windowing. 60800 left of peaks, 311000 right of peaks to include all data.
[WindowHolex,WindowHoley] = WindowTDSData(HolePosition,HoleSignal,48.39,15.84,80.97);
[WindowMgOx,WindowMgOy] = WindowTDSData(MgOPosition,MgOSignal,55.73,15.84,80.97);
[WindowFilmx,WindowFilmy] = WindowTDSData(FilmPosition,FilmSignal,55.73,15.84,80.97);

%Plotting to see if window worked correctly
figure;
plot(WindowHolex,WindowHoley,WindowMgOx,WindowMgOy,WindowFilmx,WindowFilmy)
%All vectors have the same length, looks good.

%Windowing now to only look at the first peak of each scan. 15ps left of
%peaks, 18ps right of peaks.
[WindowHolex2,WindowHoley2] = WindowTDSData(HolePosition,HoleSignal,48.39,15,18);
[WindowMgOx2,WindowMgOy2] = WindowTDSData(MgOPosition,MgOSignal,55.73,15,18);
[WindowFilmx2,WindowFilmy2] = WindowTDSData(FilmPosition,FilmSignal,55.73,15,18);

figure;
plot(WindowHolex2,WindowHoley2,WindowMgOx2,WindowMgOy2,WindowFilmx2,WindowFilmy2)

%Appodization.
[Holex_appodized, Holey_appodized, Holey_shift] = AppodizeTDSData(WindowHolex2,WindowHoley2,48.39);
[MgOx_appodized, MgOy_appodized, MgOy_shift] = AppodizeTDSData(WindowMgOx2,WindowMgOy2,55.73);
[Filmx_appodized, Filmy_appodized, Filmy_shift] = AppodizeTDSData(WindowFilmx2,WindowFilmy2,55.73);

figure;
plot(Holex_appodized,Holey_appodized,MgOx_appodized,MgOy_appodized,Filmx_appodized,Filmy_appodized)

%FFT.
[Holew, Holefd] = CalcTDSFFT_Menlo_New(Holex_appodized, Holey_appodized, 100, 0.1);
[MgOw, MgOfd] = CalcTDSFFT_Menlo_New(MgOx_appodized, MgOy_appodized, 100, 0.1);
[Filmw, Filmfd] = CalcTDSFFT_Menlo_New(Filmx_appodized, Filmy_appodized, 100, 0.1);

figure;
plot(MgOw,real(MgOfd))

cmplxtMgOHole = MgOfd./Holefd;
cmplxtFilmHole = Filmfd./Holefd;

figure;
plot(MgOw,abs(cmplxtMgOHole),MgOw,abs(cmplxtFilmHole))
legend('MgO','Film 12')



















%Centering each peak at 20 to make the signals overlay for a plot.
HoleCenteredx = WindowHolex - 28.39;
MgOCenteredx = WindowMgOx - 35.73;
FilmCenteredx = WindowFilmx - 35.73;

figure;
plot(HoleCenteredx,WindowHoley,MgOCenteredx,WindowMgOy,FilmCenteredx,WindowFilmy)
xlabel('Time (picoseconds)')
ylabel('Signal')
legend('Hole','MgO','Film')
