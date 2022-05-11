%Burn Up 
clc
clear all
close all
%konstanta reaktor
P = 3400E+6; %Nilai Daya dari reaktor AP-1000
N = 2000; %banyaknya iterasi
%nilai faktor multiplikasi reaktor
Keff = rand*10;
%syarat batas nilai fluks 
Fluks(1,1) = 0;
Fluks(N,1) = 0;
%matriks fluks dan tebakan fluks
for i=2:N-1
Fluks(i,1)=rand*100; %dilakukan penebakan nilai fluks antara 1 sampai 100
end
%Normalisasi dengan daya reaktor
sum = 0;
for i = 1:N
Fluks_N (i,1) = (36*2.4)*Fluks(i,1)/((P/1E+6)*1.6022e-13*Keff);
sum=sum+Fluks_N(i,1);
end
max_fluks = max(sum);
flux= max_fluks; % neutron/cm^2.s
n   = 0.5;
%detik*menit*jam*hari*bulan*tahun
tf  = 60*60*24*30*12*2; % 2tahun
dt  = 60*60; % detik
t   = [0:dt:tf];
% Fuel
% U-238
Nu8(1)  = 2.2968545203386600E-02;   
scu8    = 2.68e-24;
sfu8    = 16.8e-30;
sau8    = scu8+sfu8;
% U-239
Nu9(1)  = 0;
htu9    = 23.45*60;
lu9     = log(2)/htu9;
% Np-239
Nnp9(1) = 0;
htnp9   = 2.356*24*60*60;
lnp9    = log(2)/htnp9;
% Pu-239
Npu9(1) = 0;
sapu9   = 1026e-24;
sfpu9   = 741e-24;
scpu9   = sapu9-sfpu9;
% Pu-240
Npu0(1) = 0;
sfpu0   = 0.03e-24;
scpu0   = 289.5e-24;
sapu0   = scpu0+sfpu0;
% Pu-241
Npu1(1) = 0;
sfpu1   = 950e-24;
scpu1   = 362e-24;
sapu1   = sfpu1+scpu1;
htpu1   = 14*60*60*24*30*12;
lpu1    = log(2)/htpu1;
% Am-241
Nam1(1) = 0;
htam1   = 432.2*360*24*3600;
lam1    = log(2)/htam1;
% Pu-241
Npu2(1) = 0;
sfpu2   = 0.19e-24;
scpu2   = 30e-24;
sapu2   = sfpu2+scpu2;
% Total
tot(1)  = Nu8(1);
%Iterasi loop perhitungan burnup tiap bahan fisil
i = 1;

Keff_BU(1) = Keff;
Fisi_BU(1) = 0;
Fisi_BU(17281) = 0;

while (t(i) ~= tf)
% U-238
 Nu8(i+1)    = (((n-1)*sau8*flux*dt)+1)*Nu8(i)/(1+sau8*flux*dt*n);
% U-239
    Nu9(i+1)    = (scu8*flux*dt*(n*Nu8(i+1)+(1-n)*Nu8(i))+(1-(1-n)*lu9*dt)*Nu9(i))/(1+lu9*dt*n);
% Np-239
    Nnp9(i+1)   = (lu9*dt*(n*Nu9(i+1)+(1-n)*Nu9(i))+(1-(1-n)*lnp9*dt)*Nnp9(i))/(1+lnp9*dt*n);
% Pu-239
    Npu9(i+1)   = (lnp9*dt*(n*Nnp9(i+1)+(1-n)*Nnp9(i))+(1-(1-n)*sapu9*flux*dt)*Npu9(i))/(1+sapu9*flux*dt*n);
% Pu-240
    Npu0(i+1)   = (scpu9*flux*dt*(n*Npu9(i+1)+(1-n)*Npu9(i))+(1-(1-n)*sapu0*flux*dt)*Npu0(i))/(1+sapu0*flux*dt*n);
% Pu-241
    Npu1(i+1)   = (scpu0*flux*dt*(n*Npu0(i+1)+(1-n)*Npu0(i))+(1-(1-n)*(lpu1+sapu1*flux)*dt)*Npu1(i))/(1+(lpu1+sapu1*flux)*dt*n);
% Am-241
    Nam1(i+1)   = (lpu1*dt*(n*Npu1(i+1)+(1-n)*Npu1(i))+(1-(1-n)*lam1*dt)*Nam1(i))/(1+lam1*dt*n); 
% Pu-242
    Npu2(i+1)   = (scpu1*flux*dt*(n*Npu1(i+1)+(1-n)*Npu1(i))+(1-(1-n)*sapu2*flux*dt)*Npu2(i))/(1+sapu2*flux*dt*n);
% Total
    tot(i+1) = Nu8(i+1)+Nu9(i+1)+Nnp9(i+1)+Npu9(i+1)+Npu0(i+1)+Npu1(i+1)+Nam1(i+1)+Npu2(i+1);
    i = i+1;
end
%plot grafik burnup
%detik*menit*jam*hari*bulan*tahun
t = t/(60*60*24*30*12*1);

figure (1)
    plot (t,Nu8,'LineWidth',2); legend('U-238');
title('Kurva Burn Up U-238');
ylabel('Densitas Atom (atom/barn.cm)');
xlabel('t (tahun)');

figure (2)          
    plot (t,Nnp9,'LineWidth',2); 
    hold on
    plot (t,Npu9,'LineWidth',2); 
      plot (t,Npu0,'LineWidth',2); 
        plot (t,Npu1,'LineWidth',2); 
          plot (t,Npu2,'LineWidth',2);
            y = linspace(0,10,10^(-5));
            legend('Np-239','Pu-239','Pu-240','Pu-241','Pu-242');
            hold off
title('Kurva Burn Up Bahan Fisil Np dan Pu');
ylabel('Densitas Atom (atom/barn.cm)');
xlabel('t (tahun)');
figure (3)
    plot (t,Nam1,'LineWidth',2); 
    hold on
      plot (t,Nu9,'LineWidth',2); 
      y = linspace(0,10,10^(-7));
      legend('Am-241','U-239');
      hold off
title('Kurva Burn Up Am dan U-239');
ylabel('Densitas Atom (atom/barn.cm)');
xlabel('t (tahun)');

