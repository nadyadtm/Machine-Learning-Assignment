%Soal 1 : menampilkan grafik scatter
datatrn = csvread('data_train_PNN.csv');
datatest = csvread('data_test_PNN.csv');

i1 = 1;
i2 = 1;
i3 = 1;
for i=1 : 150
    if datatrn(i,4)==0 
        datakelas0(i1,:)=datatrn(i,:);
        i1=i1+1;
    elseif datatrn(i,4)==1
        datakelas1(i2,:)=datatrn(i,:);
        i2=i2+1;
    elseif datatrn(i,4)==2
        datakelas2(i3,:)=datatrn(i,:);
        i3=i3+1;
    end
end

figure
hold on
scatter3(datakelas0(:,1),datakelas0(:,2),datakelas0(:,3),'r');
scatter3(datakelas1(:,1),datakelas1(:,2),datakelas1(:,3),'g');
scatter3(datakelas2(:,1),datakelas2(:,2),datakelas2(:,3),'b' );
hold off

%mencari nilai g dan sigma yang optimal
%membagi data train dan data valid menjadi 100 dan 50 lalu membaginya per
%kelas
datatrain = datatrn(1:100,:);
datavalid = datatrn(101:150,:);
i1 = 1;
i2 = 1;
i3 = 1;
for i=1 : 100
    if datatrain(i,4)==0 
        datakelas01(i1,:)=datatrain(i,:);
        i1=i1+1;
    elseif datatrain(i,4)==1
        datakelas11(i2,:)=datatrain(i,:);
        i2=i2+1;
    elseif datatrain(i,4)==2
        datakelas21(i3,:)=datatrain(i,:);
        i3=i3+1;
    end
end

% SOAL 3 : melakukan observasi parameter dengan mencari nilai sigma yang
% optimal dengan perulangan dengan membagi data train menjadi data train
% dan data valid
gawal = 0.01;
idx = 1;
while gawal<=2
    %fungsi sigma terlampir (mencari sigma berdasarkan nilai g)
    sigmakelas0 = csigma(datakelas01,gawal);
    sigmakelas1 = csigma(datakelas11,gawal);
    sigmakelas2 = csigma(datakelas21,gawal);
    % memasukkan 50 data valid ke fungsi (fungsi terlampir)
    for i=1 : 50
        %hidden layer
        fungsikelas(i,1) = fungsi(datavalid(i,1),datavalid(i,2),datavalid(i,3),datakelas01,sigmakelas0);%hidden layer dan summation layer terdapat dalam fungsi tersebut
        fungsikelas(i,2) = fungsi(datavalid(i,1),datavalid(i,2),datavalid(i,3),datakelas11,sigmakelas1);
        fungsikelas(i,3) = fungsi(datavalid(i,1),datavalid(i,2),datavalid(i,3),datakelas21,sigmakelas2);
        %output layer
        x = max(fungsikelas(i,:));
        if x==fungsikelas(i,1)
            datavalid(i,5)=0;
        elseif x==fungsikelas(i,2)
            datavalid(i,5)=1;
        elseif x==fungsikelas(i,3)
            datavalid(i,5)=2;
        end
    end
    %menghitung jawaban yang benar pada data
    count = 0;
    for i=1 : 50
        if datavalid(i,5)==datavalid(i,4)
            count = count +1;
        end
    end
    %memasukkan akurasi beserta sigma dan g awalnya
    akurasi(idx,1) = count/50;
    akurasi(idx,2) = gawal;
    akurasi(idx,3) = sigmakelas0;
    akurasi(idx,4) = sigmakelas1;
    akurasi(idx,5) = sigmakelas2;
    %iterasi daftar akurasi
    idx = idx + 1;
    %iterasi g awal selalu dijumlahkan 0.01
    gawal=gawal+0.01;
end

%mencari nilai dengan akurasi terbesar
[akurasii, indeks_akurasi] = max(akurasi(:,1));
sigmakelas0 = akurasi(indeks_akurasi,3);
sigmakelas1 = akurasi(indeks_akurasi,4);
sigmakelas2 = akurasi(indeks_akurasi,5);

%menampilkan sigma yang optimal
disp('Nilai G ');
disp(akurasi(indeks_akurasi,2));
disp('Sigma Kelas 0 yang optimal');
disp(akurasi(indeks_akurasi,3));
disp('Sigma Kelas 1 yang optimal');
disp(akurasi(indeks_akurasi,4));
disp('Sigma Kelas 2 yang optimal');
disp(akurasi(indeks_akurasi,5));

%mencobakan datatest dengan sigma yang telah didapat
for i=1 : 30
    fungsikelas(i,1) = fungsi(datatest(i,1),datatest(i,2),datatest(i,3),datakelas0,sigmakelas0);
    fungsikelas(i,2) = fungsi(datatest(i,1),datatest(i,2),datatest(i,3),datakelas1,sigmakelas1);
    fungsikelas(i,3) = fungsi(datatest(i,1),datatest(i,2),datatest(i,3),datakelas2,sigmakelas2);
    x = max(fungsikelas(i,:));
    if x==fungsikelas(i,1)
        datatest(i,4)=0;
    elseif x==fungsikelas(i,2)
        datatest(i,4)=1;
    elseif x==fungsikelas(i,3)
        datatest(i,4)=2;
    end
end

%membagi data test menjadi perkelas
i1 = 1;
i2 = 1;
i3 = 1;
for i=1 : 30
    if datatrn(i,4)==0 
        datakelas011(i1,:)=datatrn(i,:);
        i1=i1+1;
    elseif datatrn(i,4)==1
        datakelas111(i2,:)=datatrn(i,:);
        i2=i2+1;
    elseif datatrn(i,4)==2
        datakelas211(i3,:)=datatrn(i,:);
        i3=i3+1;
    end
end

%menampilkan persebaran datatest
figure
hold on
scatter3(datakelas0(:,1),datakelas0(:,2),datakelas0(:,3),'r');
scatter3(datakelas1(:,1),datakelas1(:,2),datakelas1(:,3),'g');
scatter3(datakelas2(:,1),datakelas2(:,2),datakelas2(:,3),'b' );
scatter3(datakelas011(:,1),datakelas011(:,2),datakelas011(:,3),'r','filled');
scatter3(datakelas111(:,1),datakelas111(:,2),datakelas111(:,3),'g','filled');
scatter3(datakelas211(:,1),datakelas211(:,2),datakelas211(:,3),'b','filled');
hold off

%menulis hasil prediksi
fileID = fopen('hasil_prediksi.txt','w');
fprintf(fileID,'%6s %6s %6s %6s\r\n','atr1','atr2','atr3','y');
fprintf(fileID,'%3.9f %3.9f %3.9f %1i\r\n',datatest');
