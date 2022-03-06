%%ordin 1
load('lab2_order1_3.mat')

u=data.u; %atribuire date
y=data.y;
ts=data.Ts;

t=1:1:500;

u_id=u(1:100); %date identificare prima treapta
y_id=y(1:100);
u_val=u(201:500); %date validare ultimele 3 trepte
y_val=y(201:500);

yss=mean(y_id(90:100)); %y stationar, media ultimelor 10 valori
uss=mean(u_id(90:100));
y0=0; %val initiale 0 
u0=0;


Kt=0.632*(yss-y0); 
K=(yss-y0)/(uss-u0);
kt=15; %citit de pe grafic y(Kt)=15 apox

T=kt*ts; %4.5 tuning pentru a suprapune perfect graficele, vezi MSE

H=tf(K,[T 1]) %generare si afisare fct transfer
y_hat=lsim(H,u,t*ts);



figure(4)
y_val_hat=lsim(H,u_val,t(201:500)*ts); %aproximarea iesirii prin modelul creat
plot(y_val), hold on 
plot(y_val_hat),grid,title('Validare model ')
xlabel('t'),ylabel('y'),legend('sistem','model')
hold off

%MSE
N=length(u_val);
Mse=1/N*sum((y_val-y_val_hat).^2)


fprintf('MSE=%.4f\n',Mse)
fprintf('K=%.2f\n',K)
fprintf('T=%.2f\n',T)
disp(H)

%%ordin 2
load('lab2_order2_3.mat') %plot data, valori, legend, title
u=data.u;
y=data.y;
ts=data.Ts;

t=1:1:500;

u_id=u(1:100); %date identificare
y_id=y(1:100);
u_val=u(201:500); %date validare
y_val=y(201:500);

yss=mean(y_id(90:100)); %y stationar
uss=mean(u_id(90:100));
y0=0; %val initiale 0 
u0=0;
y_t1=9.075 %y(t1) primul max aprox 11
y_t2=4.36 % y(t2)primul minim aprox 19
y_t3=7.014; 

M1=(y_t1-yss)/yss  %a suprareglaj
M2=(yss-y_t2)/(y_t1-yss) %b

T0=29-11; %perioada intre maxime coonsecutive

K=yss/uss*1.013; %factor proportionalitate
zeta=log(1/M1)/sqrt(pi*pi+log(M1)*log(M1)); %factor amortizare
Wn=2*pi/(T0*ts*sqrt(1-zeta*zeta)); %pulsatia naturala


H=tf(K*Wn*Wn,[1 2*Wn*zeta Wn*Wn]) %generare functie transfer pt sistemul dat

y_val_hat=lsim(H,u_val,t(201:500)*ts); 
plot(y_val), hold on
plot(y_val_hat)
grid,title('Validare model ')
xlabel('t'),ylabel('y'),legend('sistem','model')
hold off

%MSE
N=length(u_val);
Mse=1/N*sum((y_val-y_val_hat).^2);

fprintf('MSE=%.2f\n',Mse)
fprintf('T0=%.2f\n',T0)
fprintf('M=%.2f\n',M1)
disp(H)

