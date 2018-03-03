%soal no 2 : membuat fungsi pdf
function hasil = fungsi(x1,x2,x3,datakelas,sigma)
%mengambil nilai n
[n, kolom]=size(datakelas);
%menghitung sigma
for i=1 : n
    jumlah = (x1 - datakelas(i,1))*(x1 - datakelas(i,1)) + ...
        (x2 - datakelas(i,2))*(x2 - datakelas(i,2)) + ...
        (x3 - datakelas(i,3))*(x3 - datakelas(i,3));
    g(i)=exp(-(jumlah/(2*sigma*sigma)));%hidden layer
end

sumlayer = sum(g);%summation layer
%menghitung final, p = 3 karena 3 dimensi
hasil = (1/(sqrt((2*3.14)^3)*sigma*sigma*sigma*n))*sumlayer;
end
