

data = readmatrix('real estate valuation data set.xlsx','Range', 'C2:H51');%membaca data dari kolom3-8
data(:,4:5) =[];%menghapus kolom x5 latitude dan x6 longitude

disp("ini adalah data awal");
disp("House Age distance to the nearest MRT station number of convenience stores house price of unit area");
disp(data);
k = [0,0,1,0];%deklarasi atribut untuk kriteria

w = [3,5,4,1];%deklarasi bobot per kriteria

[m n]=size (data);
w=w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh

for j=1:n,
    if k(j)==0, w(j)=-1*w(j);%mengalikan dengan -1 yang cost
    end;
end;

S = zeros(1,m);
for i=1:m,
    S(i)=prod(data(i,:).^w);
end;
V= S/sum(S);

%mencari nilai max dari hasil dan letak nilai mas tersebut
[M, I] = max(V);

disp("Jadi Real Esatate Terbaik Untuk Investasi Jangka panjang adalah");
disp("Rumah nomer "+ I +" Dengan data");
disp("House Age||distance to the nearest MRT station||number of convenience stores||house price of unit area");
disp(data(I,:));
disp("Dengan Nilai akhir : "+ M);