load('lab8_7.mat');

u_id=id.U;
y_id=id.Y;

Ts=id.Ts;

u_val=val.U;
y_val=val.Y;


alpha=0.1;l=1;lmax=300; % [l lmax]
conv=2e-4; %prag de conv -> valoarea cu care compar (delta)
Thetanou=[0;0]; %[f0 b0] initiali
Theta=[1;1]; % f si b
while((l<lmax) || (norm(Theta-Thetanou) > conv))
    b=Theta(1,1);f=Theta(2,1);N=length(u_id);
    Hes=0; grat=0; 
    eps=zeros(1,length(u_id)); %initializare epsilon
    eps_der(1,1)=0;eps_der(2,1)=0; 
    for k=2:N
       eps(k)=y_id(k)+f*y_id(k-1)-b*u_id(k-1)-f*eps(k-1);      
       eps_der(1,k)=-u_id(k-1)-f*eps(k-1);   %    OE GAUSS NEWTON
       eps_der(2,k)=y_id(k-1)-f*eps(k-1)-eps(k-1);
       grat=grat+eps(k)*eps_der(:,k); 
       Hes=Hes+eps_der(:,k)*eps_der(:,k)';    
    end
    Theta = Theta-alpha*(Hes^-1)*grat;
    Thetanou = Theta;
    l = l+1;

end
f = Thetanou(2,1);b = Thetanou(1,1);
F = [1 f];B = [0 b];
model = idpoly(1,B,1,1,F,0,Ts);
figure,compare(model,val),title('Model idpoly vs date validare'),
legend('model','DATAvalidare, fit=')