load('lab9_1.mat');

y_id=id.y;
u_id=id.u;

ts=id.Ts;

na=n; %ordin 2
nb=n;
nk=1;

figure,
ModelARX=arx(id,[na nb nk]);
ModelARX_val=arx(val,[na nb nk]);
compare(ModelARX,id);
legend(AutoUpdate="on")
title('Arx vs date id')

PHI_NOU=zeros(na+nb);
Y=zeros(na+nb,1);
N=length(y_id);
PHI=zeros(1,na+nb);
Z=zeros(1,na+nb);

%generare PHI (vezi ARX)
for i=1:N
    for j=1:na

        if((i-j)>0) 
            PHI(j)= -y_id(i-j);
        else
            PHI(j)=0;
        end

        if((i-nb-j)>0) 
            Z(j)=u_id(i-nb-j);
        else 
             Z(j)=0;
        end
    end
end

%Var instrumentale simple

 for i=1:N
    for j=1:nb

        if((i-j)>0)
          PHI(na+j)=u_id(i-j);
        else
           PHI(na+j)=0;
        end

       if((i-j)>0) 
           Z(j+na)=u_id(i-j);
       else 
           Z(j+na)=0;
       end
    end
    PHI_NOU=PHI_NOU+Z'*PHI;
    Y=Y+Z'*y_id(i);
    PHI_NOU=1/N*PHI_NOU;
    Y=1/N*Y;
 end

Theta_SI=PHI_NOU\Y;

C=[];
D=[];
F=[];
model=idpoly([1,Theta_SI(1:na)';],[0,Theta_SI(1+na:na+nb)'],C,D,F,0,id.Ts);
y1=sim(model,u_id);
figure,
compare(model,val);
title('Variabile instrumentale SIMPLE')
legend(AutoUpdate='on');

%var instrumentale Z
N=length(y1);
PHI_NOU=zeros(na+nb);
Y=zeros(na+nb,1);

for i=1:N
    for j=1:na

        if((i-j)>0) 
            PHI(j)= -y_id(i-j);
        else
            PHI(j)=0;
        end

        if((i-j)>0) 
            Z(j)=-y1(i-j);
        else 
            Z(j)=0;
        end
    end
    for j=1:nb
        if((i-j)>0)
          PHI(na+j)=u_id(i-j);
        else
           PHI(na+j)=0;
        end
       if((i-j)>0) 
           Z(j+na)=u_id(i-j); 
       else 
           Z(j+na)=0;
       end
    end
    PHI_NOU=PHI_NOU+Z'*PHI/N;
    Y=Y+Z'*y_id(i)/N;
end

Theta=PHI_NOU\Y;
C=[];D=[];F=[];
model_VI=idpoly([1,Theta(1:na)';],[0,Theta(1+na:na+nb)'],C,D,F,0,ts);

figure,
model_VI=iv4(val,[na nb nk]);
compare(model_VI,val,ModelARX_val);
legend(AutoUpdate="on")
title('Vi din arx vs validare')
