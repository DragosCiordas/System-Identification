%% ordin 1
load('lab3_order1_4.mat')

u=data.u; %atribuire date
y=data.y;
ts=data.Ts;

%plot(data),grid,title('Intrare si iesire sistem')

t=1:1:330;

u_id=u(1:100); %date identificare prima treapta
y_id=y(1:100);
u_val=u(101:330); %date validare ultimele 2 trepte
y_val=y(101:330);

uss=mean(u_id(90:100));
yss=mean(y_id(90:100));
u0=uss;
y0=yss;

K=yss/uss; %factor proportionalitate
t1=32;
t2=44;
ymax=max(y_id); KT=0.368*(ymax-y0)+y0;
T=t2-t1;
Hss=tf(K,[T 1])

y_hat=lsim(Hss,u,t);
y_val_hat=lsim(Hss,u_val,t(101:330));
%figure, plot(y_val), grid, hold on, plot(y_val_hat)
%plot(y_id),grid , hold on, plot(KT,'*') %pt gasire 

A=-1/T;
B=K/T;
C=1;
D=0;

Hss=ss(A,B,C,D);
y_ci=lsim(Hss,u,t,y0);
y_ci_val=lsim(Hss,u_val,t(101:330),y0);
figure,plot(y_val),grid,hold on, plot(y_ci_val)
title('Validare model ')
xlabel('t'),ylabel('y'),legend('sistem','model')
hold off

%MSE
N=length(y_val);
Mse=1/N*sum((y_val-y_val_hat).^2);

fprintf('MSE=%.2f\n',Mse)
fprintf('K=%.2f\n',K)
fprintf('T=%.2f\n',T)
disp(Hss)

%% ordin 2
load('lab3_order2_4.mat')

u=data.u; %atribuire date
y=data.y;
ts=data.Ts;

%plot(data),grid,title('Intrare si iesire sistem')

t=1:1:330;

u_id=u(1:100); %date identificare prima treapta
y_id=y(1:100);
u_val=u(101:330); %date validare ultimele 2 trepte
y_val=y(101:330);

uss=mean(u_id(90:100));
yss=mean(y_id(90:100));
u0=uss;
y0=yss;

K=yss/uss*0.98; % -2% tuning

t00=0.99;
t01=1.72;
t02=2.45; 

k00=31;
k01=54;
k02=77;

t1=1.25;
t2=2;
t3=2.59;

T0=t3-t1; %pick one
T00=2*(t2-t1);

AP=ts*sum(y_id(k00:k01)-y0);
AM=ts*sum(y0-y_id(k01:k02));

M=AM/AP; %suprareglaj
zeta=(log(1/M))/sqrt(pi*pi+log(M)*log(M)); %fact amortizare

WN=2*pi/T0/sqrt(1-zeta*zeta); %pulsatia naturala 
Wn=2/T0*sqrt(pi*pi+log(M)*log(M))*0.9; % -10% 

%generare functie de transfer
H=tf(K.*Wn.*Wn,[1 2*zeta.*Wn Wn.*Wn])
y_hat=lsim(H,y_val,t(101:330)*ts);

A=[0 1;-Wn.*Wn -2*zeta.*Wn];
B=[0;K.*Wn.*Wn];
C=[1 0];
D=0;

Hss=ss(A,B,C,D);
y_ci=lsim(Hss,u,t*ts,[y0 0]);
y_ci_val=lsim(Hss,u_val,t(101:330)*ts,[y0 0]); %conditii initiale x1(0)=y0 si x2(0)=0

figure,plot(y_val),grid,hold on, plot(y_ci_val)
title('Validare model ')
xlabel('t'),ylabel('y'),legend('sistem','model')
hold off

%MSE
N=length(y_val);
Mse=1/N*sum((y_val-y_hat).^2);

fprintf('MSE=%.2f\n',Mse)
fprintf('T0=%.2f\n',T0)
fprintf('M=%.2f\n',M)
disp(Hss)
disp(H)