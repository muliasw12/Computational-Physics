% Persamaan Difusi 1D
clc
clear all 
%%

%Fungsi yang akan digunakan
flux = @(Fbaru, Flama, dx, S, D, Sa) ((((Fbaru+Flama)/(dx*dx))+(S/D))/((Sa/D)+(2/(dx*dx))));
%Konstanta Reaktor
Sa = 9.24*10^(-2);        %cross section absorbsi
Sf = 3.08*10^(-4);     %cross section fisi 
vSf = 0.145;     
errormax = 1E-4;  %error maksimum
itermax = 100;   %iterasi maksimum 
L = 1.8;          %panjang batang reaktor
D = 0.16;            %konstanta difusi
%Input Parameter
tebakan_fluks = 100;
nmax = 25;
dx = L/nmax;
%Definisi Variabel dan Matriks
Flama = zeros (nmax,1);  %nilai fluks lama 
Fbaru = zeros (nmax,1);  %nilai fluks baru
S = zeros (nmax,1);      %nilai sumber neutron
keff = zeros (nmax,1);   %nilai faktor multiplikasi
for i = 2 : nmax-1
    S(i) = 100; %Sumber neutron
end
for i = 1 : nmax
    x(i) = i;
end
%Syarat Batas Pada Ruang Vakum
Flama(1) = 0; Flama(nmax) = 0;
Fbaru(1) = 0; Fbaru(nmax) = 0;
S(1) = 0; S(nmax) = 0;
%Tebakan Awal Fluks
for i = 2 : nmax-1
    Flama(i) = tebakan_fluks;
end
%Proses Iterasi
iter = 1; konvergen = 0;
while (konvergen == 0 & iter < itermax)
    konvergen = 1;
    for i = 2 : nmax-1
        Fbaru(i) = flux(Flama(i+1), Flama(i-1), dx, S(i), D, Sa);
    end
    for i = 1 : nmax
        error = abs (Fbaru(i)-Flama(i));
        if error > errormax
            konvergen = 0;
        end
    end
    for i = 2 : nmax-1
        Flama(i) = Fbaru(i);
    end
    iter = iter + 1;
end
plot(x,Fbaru,'LineWidth',2)
title ('Plot Fluks Neutron Terhadap Posisi');
xlabel ('Posisi (cm)');
ylabel ('Fluks Neutron (neutron/cm^2.s)');

