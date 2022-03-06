load('lab6_4.mat')

x_id=id.X; %date identificare
y_id=id.Y;

x_val=val.X; %date validare
y_val=val.Y;

na=5;
nb=5;

PHI=zeros(length(y_id),na+nb);
% THETA=zeros(na+nb,1);
%generare matrice PHI 
y_hat=[];
for k=1:length(y_id)
    for i=1:na
        if((k-i)>0) 
        PHI(k,i)=-y_id(k-i);
        end
    end
    for i=1:nb
        if((k-i)>0) 
        PHI(k,na+i)=u_id(k-i);
        end
    end
    y_hat(i)=i*THETA;
end

%Generare mat. theta -> arx
THETA=PHI\y_id;

%%PREDICTIE
for i=1:length(y_id)
    
    y_hat(i)=i*THETA;
end

