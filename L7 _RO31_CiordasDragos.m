%%
load('uval.mat')
index=3;m=3;c=0.5;b=1;N=300
data=system_simulator(index,u);
%se observa o suprapunere foarte buna
m=10;c=0.5;b=1;
ug=get_spab(N,m,c,b)
model=system_simulator(index,ug')
arx_model=arx(model,[15,15,1]);
figure,compare(arx_model,data);
%data=system_simulator(index,u)

function spab=get_spab(N,m,c,b) %semal pseudo-aleator binar
a=zeros(1,m);
x=zeros(1,m);
u=zeros(1,N);
    if(m==3)
      a(1)=1;
      a(3)=1;
      x(2)=1;
    end
for i=1:N
fzf=[eye(m-1) zeros(m-1,1)] %
X=mod([a;fzf]*x',2);% generare matrice 
u(i)=X(end); % [0 0 0 0 ... 1] * x(i)
spab(i)=b+(c-b)*u(i); %scalare semnal
x=X';
end
end




