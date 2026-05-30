clc;
clear;
close all;

% Membaca Foto
I = imread("OPTK_PJ2_SET_006_MXA237.jpg");

% Mengambil warna Merah
R = I(:,:,1);

% Mengambil Rentang
for i=1:1:200
    for j=1:1:1000
        r(i,j) = R(i+170, j+683); 
    end
end

% Membuat sumbu vertikal maksimal 1
Sr=sum(r)/200;
Sn=Sr/max(Sr);

% Membuat rentang -500 sampai 500
for j=1:1:1000
    x(j)=j-500;
end

% Membuat i_teori
beta=linspace(-2*pi,2*pi,736);
I_teori=(sin(beta)./beta).^2;
% plot(beta, I_teori, x, Sn)

for n=1:1:736
    Sn2(n)=Sn(n+132);
end

% Mengubah data dimulai dari 0 terhadap sumbu-x
Sn2=(Sn2-min(Sn2))/(max(Sn2)-min(Sn2));

for m=1:1:736
    y(m)=(m-361)/(371/(2*pi));
end

% plot(y, Sn2)
plot(beta, I_teori, y, Sn2)

% MSE untuk Grafik
Se=0;
for n=1:1:736
    Se=Se+(I_teori(n)-Sn2(n))^2;
end
MSE=Se/736;

% Lebar Celah
lam=6.6*10^-5; % Panjang Gelombang Dalam cm
L=200; % Jarak Dari Celah ke Layar Dalam cm
P=1.5; % Periode yang diukur secara langsung menggunakan penggaris dalam cm
a=(lam/P)*((L^2)+(P^2))^0.5;
