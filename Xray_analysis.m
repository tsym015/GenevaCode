%Films below were grown without RF bias at 350C under various pressures.
%Other than the difference in pressure, the films are identical. All 3 were
%grown for 5min. 

NoRF_8p = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/No_RF_bias/5min_350C_8.5mbar/x_ray/NoRF_8.5p_FullScan_Fixed.csv');
NoRF_5p = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/No_RF_bias/5min_350C_5.0mbar/x_ray/NoRF_5.0p_FullScan_Fixed.csv');
NoRF_2p = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/No_RF_bias/5min_350C_2.5mbar/x_ray/NoRF_2.5p_FullScan_Fixed.csv');

x = NoRF_5p(:,1);
y1 = NoRF_5p(:,2);
y2 = NoRF_2p(:,2);
y3 = NoRF_8p(:,2);

%Plotting the two full scan overlayed
figure;
semilogy(x,y1);
hold on;
semilogy(x,y2);
title('No RF 5min 4350C X-ray Scans');
xlabel('2Theta (degrees)');
ylabel('Counts');
legend('P = 5.0x10-3', 'P = 2.5x10^-3');

figure;
semilogy(x,y1);
hold on;
semilogy(x,y3);
title('No RF 5min 350C X-ray Scans');
xlabel('2Theta (degrees)');
ylabel('Counts');
legend('P = 5.0e-3', 'P = 8.5e-3');


%Plotting 2.5p scan for final paper plot

figure;
semilogy(x,y2)
xlabel('2\theta (degrees)')
ylabel('Counts')







%Films below were grown using RF bias for 5min at 400C. Two Films that are virtually identical will be
%compared with these conditions. Ideally, 5min growth should yeild 60nm
%films. Expect to see more epitaxial growth since layers wont collapse back
%to prefered orientation of 111.

film1 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/RF_bias/5min_400C_scan_2/AuMgO_5min_400C_FullScanFixed_2.csv');
film2 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/RF_bias/5min_400C_scan_3/AuMgO_5min_400C_FullScanFixed_3.csv');
film1Xray = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/RF_bias/5min_400C_scan_2/Reflection_2_fixed.csv');
film2Xray = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/RF_bias/5min_400C_scan_3/Reflection_3_fixed.csv');


X = film1(:,1);
Y1 = film1(:,2);
Y2 = film2(:,2);

%Plotting the full scans overlayed with each other

figure;
semilogy(X,Y1);
hold on;
semilogy(X,Y2);
title('5min 400C X-ray Scans')
xlabel('2Theta (degrees)')
ylabel('Counts')
legend('Film 1', 'Film 2');

%Plotting individual scans
figure;
semilogy(X,Y1);
title('Film 1: 5min 400C X-ray Scan')
xlabel('2Theta (degrees)')
ylabel('Counts')

figure;
semilogy(X,Y2);
title('Gold film grown for 5min at 400C')
xlabel('2Theta (degrees)')
ylabel('Counts')

%Plotting small angle reflection scans

figure;
semilogy(film1Xray(:,1),film1Xray(:,2));
title('5min 400C (1) Small Angle Reflection Scan')
xlabel('2Theta (degrees)')
ylabel('Counts')

figure;
semilogy(film2Xray(:,1),film2Xray(:,2));
title('5min 400C (2) Small Angle Reflection Scan')
xlabel('2Theta (degrees)')
ylabel('Counts')

%Plotting both small angle reflection scans overlayed

figure;
semilogy(film1Xray(:,1),film1Xray(:,2));
hold on;
semilogy(film2Xray(:,1),film2Xray(:,2));
title('5min 400C Small Angle Reflection Scans Overlayed')
xlabel('2Theta (degrees)')
ylabel('Counts')
legend('Film 1', 'Film 2')










%Grown for 40min at various temperatures

C300 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/RF_bias/40min_300C_scan/300C.csv');
C350 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/RF_bias/40min_350C_scan/350C.csv');
C400 = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/RF_bias/40min_400C_scan/400C.csv');

%The following two imports are of the first gold growth for 5min at 400C
%with RF bias.

Min5C400Reflect = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/RF_bias/5min_400C_scan_1/Reflection0.5_4(Aligned).csv');
Min5C400Full = csvread('/Users/Tylersym/Desktop/GenevaMatlab/Data/AuMgO/RF_bias/5min_400C_scan_1/AuMgO_5min_400C_FullScan(issues).csv');


X = C400(:,1);
Y300 = C300(:,2);
Y350 = C350(:,2);
Y400 = C400(:,2);


%Plotting 400C 40 min x-ray scan

figure;
semilogy(X,Y400)
xlabel('2Theta (degrees)')
ylabel('Counts')
title('Gold film grown for 40min at 400C')

%Plotting the full scans overlayed with each other

figure;
semilogy(X,Y300);
hold on;
semilogy(X,Y350);
hold on;
semilogy(X,Y400);
title('300, 350, 400C X-ray Scans')
xlabel('2Theta (degrees)')
ylabel('Counts')
legend('300C', '350C', '400C');

%Plotting the reflections to see if we can determine thickness (not
%successful)

Xreflect = Min5C400Reflect(:,1);
Yreflect = Min5C400Reflect(:,2);
figure;
semilogy(Xreflect,Yreflect);

X5min = Min5C400Full(:,1);
Y5min = Min5C400Full(:,2);
figure;
semilogy(X5min,Y5min);


