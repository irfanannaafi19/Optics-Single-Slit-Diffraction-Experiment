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

% Mmebuat sumbu vertikal maksimal 1
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

% MSE
%Se=0;
% for n=1:1:736
%    Se=Se+(I_teori(n)-Sn2(n))^2;
%end
%MSE=Se/736;

% Rentang
% k=1:0.1:736;

% for z=1:1:length(k)
    
