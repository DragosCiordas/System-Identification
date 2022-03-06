clc; clear all;close all

load('lab5_6.mat');
uid = id.u;
yid = id.y;
plot(tid(1:100),[uid(1:100),yid(1:100)]);
yval = val.y;
uval = val.u;
m=80;

fir1=cra(detrend(id),m,0);
plot(fir1);
fir2=impulseest(detrend(id),m) ;
fir2=tfdata(fir2);
fir2=fir2{1};
plot(fir2);
y1=conv(fir1,uval);
y2=conv(fir2,uval);
y1=y1(1:length(yval));
y2=y2(1:length(yval));
e1=(yval-y1).^2;
mse1=sum(e1)/length(e1);
figure;
plot(tval,[uval,yval,y1]);
title(['mse1=',num2str(mse1)]) ;
e2=(yval-y2).^2;
mse2=sum(e2)/length(e2);
figure;
plot(tval,[uval,yval,y2]);
title(['mse2=',num2str(mse2)])