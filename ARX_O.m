load('lab6_4.mat');

y_id=id.y;
u_id=id.u;

u_val=val.u;
y_val=val.y;

na=3;nb=3;
%na=8;nb=8;

%Generare matrice PHI
PHIid=zeros(length(y_id), na+nb);
for i=1:length(y_id)
    for j=1:na
        if((i-j)>0)
            PHIid(i,j)=-y_id(i-j); 
        else 
            PHIid(i,j)=0;
        end
    end
    for j=1:nb
        if((i-j)>0)
            PHIid(i,na+j)=u_id(i-j);
        else
            PHIid(i,j)=0;
        end
    end
end
THETA = PHIid\y_id;

%Predictie, iesirile reale sunt cunoscute
N = length(y_id);
y_hat = zeros(1,N);
for i = 1:N
  z = zeros(1,na+nb);
        
  for j = 1:na
       if((i-j)>0)
             z(j)=-y_id(i-j);
       else
             z(j)=0;
       end
   end

   for j = 1:nb
       if((i-j)>0)
          z(na+j)=u_id(i-j);
       else
          z(na+j)=0;
       end
   end
   
   y_hat(i) = z*THETA;
end
    
%Simulare, folosind iesirile generate anterior
N = length(y_id);
y_hat_p= zeros(1,N);
for i = 1:N
  z = zeros(1,na+nb);
        
  for j = 1:na
       if((i-j)>0)
             z(j)=-y_hat(i-j);
       else
             z(j)=0;
       end
   end

   for j = 1:nb
       if((i-j)>0)
          z(na+j)=u_id(i-j);
       else
          z(na+j)=0;
       end
   end
   
   y_hat_p(i) = z*THETA;
end

mp_id= mean((y_id'-y_hat_p).^2)
ms_id= mean((y_id'-y_hat).^2)

figure,hold on,
title('ID')
plot(y_id),
plot(y_hat_p),
plot(y_hat),
legend('ID','ID_Pred','ID_SIM')
hold off

%Predictie, iesirile reale sunt cunoscute
N = length(y_val);
y_hat = zeros(1,N);
for i = 1:N
  z = zeros(1,na+nb);
        
  for j = 1:na
       if((i-j)>0)
             z(j)=-y_val(i-j);
       else
             z(j)=0;
       end
   end

   for j = 1:nb
       if((i-j)>0)
          z(na+j)=u_val(i-j);
       else
          z(na+j)=0;
       end
   end
   
   y_hat(i) = z*THETA;
end
    
%Simulare, folosind iesirile generate anterior
N = length(y_val);
y_hat_p= zeros(1,N);
for i = 1:N
  z = zeros(1,na+nb);
        
  for j = 1:na
       if((i-j)>0)
             z(j)=-y_hat(i-j);
       else
             z(j)=0;
       end
   end

   for j = 1:nb
       if((i-j)>0)
          z(na+j)=u_val(i-j);
       else
          z(na+j)=0;
       end
   end
   
   y_hat_p(i) = z*THETA;
end

mp_val= mean((y_val'-y_hat_p).^2)
ms_val= mean((y_val'-y_hat).^2)

figure,hold on,
title('VAL'),
plot(y_val),
plot(y_hat_p),
plot(y_hat),
legend('VAL','VAL_Pred','VAL_SIM')
hold off
