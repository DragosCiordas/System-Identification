load('lab10_1.mat');
Uid=id.u;
Yid=id.y;
N=length(Yid);

%conditii initiale
na=3*n;nb=na;Theta=zeros(na+nb,1);
P=100*eye(na+nb);
%arx recursiv
N = length(Uid)
for i=1:N;
    phi=[];
    for j=1:na
        if(i-j)>0
        phi(j)=-Yid(i-j);else phi(j)=0;
        end
    end
    for j=1:nb                 
        if(i-j)>0
            phi(j+na)=Uid(i-j);else phi(j+na)=0;
        end
    end
     phi=phi';
     %eroare de predictie
     e=Yid(i)-phi'*Theta;
     %inversa p
     P=P - (P*phi*phi'*P)/(1+phi'*P*phi);
     %calcul ponderi
     W=P*phi;
     %actualizare parametrii
     Theta=Theta+W*e; 
end
A=[1 Theta(1:na)'];
B=[0 Theta(1+na:na+nb)'];
%arx recursiv implementat
sys1=idpoly(A,B,[],[],[],1,id.Ts);
% compare(sys,val);
nk=1;
Theta0=zeros(na+nb,1);          
P0=100*eye(na+nb);
model = rarx(id, [na, nb, nk], 'ff', 1, Theta0, P0);
t=model(end,:);
A2=[1 t(1:na)];
B2=[0 t(1+na:na+nb)];
%arx recursiv cu functia rarx
sys2=idpoly(A2,B2,[],[],[],1,val.Ts);
compare(sys2,val,sys1);