load('lab8_7.mat');

u_id=id.U;
y_id=id.Y;

u_val=val.U;
y_val=val.Y;


alpha=0.1; %pas de convergenta
l=1;% delimitare numar iteratii
lmax=300; % [l lmax]

conv=2e-4; %prag de conv -> valoarea cu care compar (delta)
Thetanou=[0;0]; %[f0 b0] initiali
Theta=[1;1]; % f si b


while( (norm(Theta-Thetanou) > conv) || (l<lmax) )
    
    b=Theta(1,1);
    f=Theta(2,1);
    N=length(u_id);

    %e(1)=y_id(1);
    grat=0;
    Hes=0; %Hessian
    eps_der(1,1)=0; %epsilon'
    eps_der(2,1)=0; %epsilon"
    eps=zeros(1,N);

    for k=2:N
        %formulele determinate pe parcursul laboratorului
        %perturbatia epsilon = eroare de predictie e 
       eps(k)=y_id(k)+f*y_id(k-1)-b*u_id(k-1)-f*eps(k-1); 

       eps_der(1,k)=-u_id(k-1)-f*eps(k-1);

       eps_der(2,k)=y_id(k-1)-f*eps(k-1)-eps(k-1);
       %Formula gradient
       grat=grat+eps(k)*eps_der(:,k); 
       %Hessian dubla derivata 
       Hes=Hes+eps_der([1 2],k)*eps_der(:,k)';    
    end
% 
%     grat = 2/N*grat;
%     Hes = 2/N*Hes;

    %inv(H)*dV
    Theta = Theta-alpha*inv(Hes)*grat;
    Thetanou = Theta;
    l = l+1;

end

b = Thetanou(1,1);
f = Thetanou(2,1);

 B = [0 b];
F = [1 f];

Ts=id.Ts;

model = idpoly(1,B,1,1,F,0,Ts);
figure,compare(model,val),title('Model idpoly vs date validare'),
legend('model','DATAvalidare, fit=')