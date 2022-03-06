load('lab5_6.mat');

%date furnizate
%figure(1),stem(imp) %rezultat de verificare raspuns la impuls
% figure(2),plot(id)
% figure(3),plot(val)

u_id = id.u;
y_id = id.y;

y_val = val.y;
u_val = val.u;

%se observa ca semnalele de intrare si iesire nu sunt de medie 0
u_id=u_id-mean(u_id);
y_id=y_id-mean(y_id);

%verificare medie 0
% figure(4),plot(tid,u_id);
% figure(5),plot(tid,y_id);

m=63; %valoare k intrare in reg stationar
for i=1:length(tid) %conventia i=tau
 ryu(i)=0;
 ru(i)=0;
for j=1:(length(u_id)-i) %conventia j=k
  ryu(i)=ryu(i)+y_id(j+i-1)*u_id(j)*1/length(u_id);
  ru(i)=ru(i)+u_id(j+i-1)*u_id(j)*1/length(u_id);
end
% ryu=ryu*1/lenght(u_id);
% ru=ru*1/lenght(u_id);
end

%generare matrice psi
psi=[];
for i=1:length(tid)
 for j=1:m
 L(j)=ru(abs(i-j)+1); %generez linia
 end
 psi=[psi;L]; %o pun in matrice
end
fir=psi\ryu'; %h
figure(5),stem(fir),title('Raspuns estimat la impuls')
xlabel('lags'),
y_val_hat=conv(fir,u_val); y_id_hat=conv(fir,u_id);
y_val_hat=y_val_hat(1:length(y_val)); %trunchiere la valoarea

%calculare MSE
N=length(y_id);
Mse=1/N*sum((y_val_hat-y_val).^2);

figure(6),

plot(tval,u_val), hold on
plot(tval,y_val)
plot(tval,y_val_hat)
hold off

title(['Ysis vs Yval, MSE=',num2str(Mse)])
legend('uval','yval','ysis')
xlabel('t'),ylabel('yhat,y_hat,u_val');

figure(7),
plot(tid,y_id),title('raspuns la intrare uid'),hold on
a=conv(u_id,fir);
plot(tid,a(1:length(y_id))),
xlabel('time (s)'),ylabel('Amplitude')
hold off