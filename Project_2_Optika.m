clc;
clear;
close all;

% Membaca dan mengambil data warna dari foto
I = imread("OPTK_PJ2_SET_006_MXA237.jpg");

% Mengambil warna merah (R) untuk semua kolom dan baris
R = I(:,:,1);

% Memotong foto
for i=1:1:200
    for j=1:1:1000
        r(i,j) = R(i+170, j+683);  
    end
end

Sr=sum(r)/200;
% plot(Sr)

Sn=Sr/max(Sr);
% plot (Sn)

for j=1:1:1000
    x(j)=j-500;
end
% plot(x,Sn)

beta=linspace(-2*pi,2*pi,736);
I_teori=(sin(beta)./beta).^2;
% plot(beta, I_teori, x, Sn)

for n=1:1:736
    Sn2(n)=Sn(n+132);
end

for m=1:1:736
    y(m)=(m-361)/(361/(2*pi));
end

% plot(y, Sn2)
plot(beta, I_teori, y, Sn2)
