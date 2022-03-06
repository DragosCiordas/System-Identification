load('lab4_14.mat')
x=id.X; 
y=id.Y;

x_id=id.X; %date identificare
y_id=id.Y;

x_val=val.X; %date validare
y_val=val.Y;

Mse_val=[];
Mse_id=[];

figure,plot(x_id,y_id),title('Date identificare'),xlabel('x_{id}'),ylabel('y_{id}'),

m=25; %grad
Y_id=y_id(:); %generez matrice coloana

Retine=[];
Retine_val=[];

for n=1:m  

    %Initializare 
PHI=[];
rand=[];
Mse=[];

%generare PHI Φ

for i=1:length(x_id)
    for j=1:n
        rand = [rand x_id(i)^(j-1)]; %construire polinom grad n-1
    end
PHI=[PHI;rand]; 
rand=[];
end

THETA=PHI\Y_id
Y_hat=PHI*THETA; %iesire aproximata pe datele de identificare
Retine=[Retine Y_hat]

%generare phi pe date de validare
PHI_val=[];
rand_val=[];

for i=1:length(x_val)
    for j=1:n
        rand_val = [rand_val x_val(i)^(j-1)];
    end
PHI_val=[PHI_val;rand_val];
rand_val=[];
end

Y_hat_val=PHI_val*THETA;
Retine_val=[Retine_val Y_hat_val]

%MSE identificare
Nid=length(y_id);
Mse_id=[Mse_id 1/Nid*(sum((y_id-Y_hat').^2))];

%MSE validare
Nv=length(y_val);
Mse_val=[Mse_val 1/Nv*(sum((y_val-Y_hat_val').^2))];
end

%Mse_min=min(Mse_val); %caut eroarea minima pe validare

%caut n-ul (gradul) corespunzator Mse_min
% for i=1:m
% if(Mse_val(i)== Mse_min)
%     grad=i;
% end
% end
%sau mult mai simplu
[Mse_min,grad] = min(Mse_val)

n=1:1:m;
figure, plot(n,Mse_id),hold on, plot(n,Mse_val),title(strcat('MSE id vs val, MSE_{min}=',num2str(Mse_min))), legend('MSE_{id}','MSE_{val}')

%reprezentare grafica Phi_id si Phi_val pt gradul in care Mse are val
%minima pe validare

figure, plot(x_id,y_id), hold on, plot(x_id,Retine(:,grad-1)),title('\Phi_{id}') 
ylabel('y_{id}'),xlabel('x_{id}')


figure, plot(x_val,y_val), hold on, plot(x_val,Retine_val(:,grad-1)), title('\Phi_{val}')
ylabel('y_{val}'),xlabel('x_{val}')