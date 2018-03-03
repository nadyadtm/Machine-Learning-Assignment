%soal no 2 : membuat fungsi mencari sigma
function hasil = csigma(datakelas, g)
[n, kolom]=size(datakelas);
for a=1 : n
    x = 1;
    for b = 1 : n
        if a~=b
            x1=datakelas(a,1)-datakelas(b,1);
            x2=datakelas(a,2)-datakelas(b,2);
            x3=datakelas(a,3)-datakelas(b,3);
            jarakkelas(x)=sqrt(x1*x1 + x2*x2 + x3*x3);
            x=x+1;
        end
    end
    jarakterkecil(a)=min(jarakkelas);
end
hasil = g*mean(jarakterkecil);
end
