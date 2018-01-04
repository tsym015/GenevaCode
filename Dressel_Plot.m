
%This code replicates the plot found in Dressel's book. It shows sigma 1
%and sigma 2 plotted over a range of wavelengths. Once we know sigma 1 and
%sigma 2, it will ultimately let us calculate k and n for our gold film.
%This plotting is to practice for the gold calculation.

eps0 = 8.854187817e-14;
c_cm = 2.99792458e+10;
sigma_factor = 2*pi*eps0*c_cm;
wp = 1.885e+15; % in Hz, vp*2*pi*c
vp = 1e+04; % in cm-1
gamma = 16.8; % in cm-1, wn where sig1 and sig2 are equal
sigDC = sigma_factor*vp^2/gamma; %in ohms-1 cm-1 
t = 1/(gamma); % NOT in sec. Divide by 2*pi*c to get value in sec.
w = logspace(-4,4,10000);

sigCplx = sigDC./(1 - 1i.*w.*t);
sig1 = real(sigCplx);
sig2 = imag(sigCplx);

figure;
semilogx(w,sig1);
hold on;
semilogx(w,sig2);
title('Recreation of Dressel sig1 & sig2 plot');
legend('sig1', 'sig2');
xlabel('Wavenumber (cm-1)')
ylabel('Conductivity (Ohm-1 cm-1)')








%now creating the same type of plot, but subing in the values of wp and
%sigDC for gold (found online)

eps0 = 8.854187817e-14;
c_cm = 2.99792458e+10;
sigma_factor = 2*pi*eps0*c_cm;
AUfp = 2.149811716e15; % in Hz
AUwp = 2*pi*AUfp; % in rad/sec
AUvp = AUwp/(2*pi*c_cm); % in cm-1. This was given by Zeman source
AUsigDC = 4.516711834e+05; %in ohms-1 cm-1, converted from value on Wiki for 20C
AUgamma = AUvp^2*sigma_factor/(AUsigDC); % in cm-1, wn where sig1 and sig2 are equal
AUt = 1/(AUgamma); % NOT in sec. Divide by 2*pi*c to get value in sec.
AUw = logspace(0,2,10000);

AUsigCplx = AUsigDC./(1 - 1i.*AUw.*AUt);

figure;
semilogx(AUw,real(AUsigCplx));
hold on;
semilogx(AUw,imag(AUsigCplx));
title('Gold sig1 & sig2 plot');
legend('sig1', 'sig2');
xlabel('Wavenumber (cm-1)')
ylabel('Conductivity (Ohm-1 cm-1)')

%Solving for complex epsilon from sigma
AUepsCplx = (AUsigCplx/sigma_factor/(-1i)./AUw)+1;

%Solving for complex n from complex epsilon
AUnCplx = AUepsCplx.^(1/2);

%Plotting the real and complex parts of n for gold
figure;
semilogx(AUw,real(AUnCplx));
figure;
semilogx(AUw,imag(AUnCplx));

%Now that we have a vector for complex n, we can plug those values (which are
%functions of frequency wn) back into the original equation for
%transmission

n1 = 1;
n3 = 1;
AUw; %In cm-1. This is what will be plotted on the x-axis.
lambda = 1./AUw;%in cm. This is for the input lambda in the equation. It needs to be input in wavelength, not wavenumbers.
nm_cm = 1e-07; %Conversion for nm to cm
t12 = 2*n1./(n1 + AUnCplx);
t23 = 2*AUnCplx./(AUnCplx + n3);
r12 = (n1 - AUnCplx)./(n1 + AUnCplx);
r23 = (AUnCplx - n3)./(AUnCplx + n3);
d = 0.2*nm_cm; %Will give d in cm for equation.
d_phase = 1i.*(2*pi*d.*AUnCplx./lambda);

AUTransmissionCmplxUp = t12 .* exp(d_phase) .* t23; %Numerator of total transmission fraction

AUTransmissionCmplxDown = 1 + r12 .* r23 .* exp(2*d_phase); %Denominator of total trans. fraction

AUTransmissionCmplxTotal = AUTransmissionCmplxUp./AUTransmissionCmplxDown;

figure;
loglog(AUw,(abs(AUTransmissionCmplxTotal)));
title('Transmission of gold films at various thicknesses');
xlabel('Wavenumber (cm-1)');
ylabel('Transmission (intensity)');

hold on
semilogx(AUw,abs(AUTransmissionCmplxTotal));

legend('10nm', '100nm', '1.0um', '10um')

legend('54nm', '108nm')












%Now creating a plot of sigma for MgO with value of complex epsilon
%calculated from a published report (Yang, et. al. 1990)

MgOw = logspace(0,2,10000);

%Solving for complex epsilon from function given in paper. Using data for
%290K
Einf = 3.01;

wt1 = 403;
wt2 = 279;
wt3 = 110;
S1 = 5.6;
S2 = 0.27;
S3 = 0.11;
G1 = 0.0067;
G2 = 64;
G3 = 3.7;

Sum1 = (S1*(wt1^2))./(wt1^2 - MgOw.^2 - (1i*MgOw*G1));
Sum2 = (S2*(wt2^2))./(wt2^2 - MgOw.^2 - (1i*MgOw*G2));
Sum3 = (S3*(wt3^2))./(wt3^2 - MgOw.^2 - (1i*MgOw*G3));

SumTotal = Sum1 + Sum2 + Sum3;

MgOepsCplx = Einf + SumTotal;

figure;
semilogx(MgOw,real(MgOepsCplx),MgOw,imag(MgOepsCplx));
legend('real eps.', 'imag eps.');

%Solving for complex sigma from epsilon
MgOsigCplx = (MgOepsCplx - 1)*sigma_factor*(-1i).*MgOw;

figure;
semilogx(MgOw, real(MgOsigCplx), MgOw, imag(MgOsigCplx))
legend('real sigma', 'imag sigma');

%Solving for complex n from complex epsilon
MgOnCplx = MgOepsCplx.^(1/2);

%Creating a plot of transmission as a function of freq. wn.
n1 = 1;
n3 = 1;
MgOw; %In cm-1. This is what will be plotted on the x-axis.
lambda = 1./MgOw;%in cm. This is for the input lambda in the equation. It needs to be input in wavelength, not wavenumbers.
d = 0.1; %Will give d in cm for equation.
t12 = 2*n1./(n1 + MgOnCplx);
t23 = 2*MgOnCplx./(MgOnCplx + n3);
r12 = (n1 - MgOnCplx)./(n1 + MgOnCplx);
r23 = (MgOnCplx - n3)./(MgOnCplx + n3);
d_phaseMgO = 1i.*(2*pi*d.*MgOnCplx./lambda);

MgOTransmissionCmplxUp = t12 .* exp(d_phaseMgO) .* t23; %Numerator of total transmission fraction

MgOTransmissionCmplxDown = 1 + r12 .* r23 .* exp(2*d_phaseMgO); %Denominator of total trans. fraction

MgOTransmissionCmplxTotal = MgOTransmissionCmplxUp./MgOTransmissionCmplxDown;

figure;
loglog(MgOw,(abs(MgOTransmissionCmplxTotal)));
title('Transmission of MgO films at various thicknesses');
xlabel('Wavenumber (cm-1)');
ylabel('Transmission (intensity)');















%Creating a plot of the transmission of the MgO with the gold film on it.
AUnCplx;
MgOnCplx; %These two vectors for the complex value of n for Au and MgO are computed using various methods above. 
n1 = 1; 
n4 = 1; %Assuming we are working in extreme vacuum
MgO_AUw = MgOw; % = AUw; %In cm-1. This is what will be plotted on the x-axis.This equality MUST be true to create the transmission... check previous steps in code.
lambda = 1./MgO_AUw;%in cm. This is for the input lambda in the equation. It needs to be input in wavelength, not wavenumbers.
nm_cm = 1e-07; %Conversion for nm to cm
t12 = 2*n1./(n1 + MgOnCplx);
t23 = 2*MgOnCplx./(MgOnCplx + AUnCplx);
t34 = 2*AUnCplx./(AUnCplx + n4);
r12 = (n1 - MgOnCplx)./(n1 + MgOnCplx);
r23 = (MgOnCplx - AUnCplx)./(MgOnCplx + AUnCplx);
r34 = (AUnCplx - n4)./(AUnCplx + n4);
d_MgO = 0.1; %Will give d in cm for equation.
d_AU = 100*nm_cm;
d_phaseAU = 1i.*(2*pi*d_AU.*AUnCplx./lambda);
d_phaseMgO = 1i.*(2*pi*d_MgO.*MgOnCplx./lambda);

MgO_AUTransmissionCmplxUp = t12 .* t23 .* t34 .* exp(d_phaseMgO + d_phaseAU); %Numerator of total transmission fraction

MgO_AUTransmissionCmplxDown = 1 + r12 .* r23 .* exp(2*d_phaseMgO) + r23 .* r34 .* exp(2*d_phaseAU) + r12 .* r34 .* exp(2*(d_phaseMgO + d_phaseAU));; %Denominator of total trans. fraction

MgO_AUTransmissionCmplxTotal = MgO_AUTransmissionCmplxUp./MgO_AUTransmissionCmplxDown;



figure;
loglog(MgO_AUw,(abs(MgO_AUTransmissionCmplxTotal)));
title('Transmission of AuMgO films at various thicknesses of gold');
xlabel('Wavenumber cm-1');
ylabel('Transmission |t|');


hold on
semilogy(AUw,(abs(MgO_AUTransmissionCmplxTotal)));

legend('50nm Au', '100nm Au');

legend('10 nm', '100 nm', '1.0 um', '10 um')





