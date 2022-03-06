load('uval.mat')
index=3;

m=3;
c=0.5;
b=1;
N=300

data=system_simulator(index,u);

%figure,plot(data)

uh=get_spab(N,m,c,b);
plot(uh);


ug=get_spab(N,m,c,b)
model=system_simulator(index,ug')
arx_model=arx(model,[15,15,1]);
figure,compare(arx_model,data);

%se observa o suprapunere foarte buna
m=10;
c=0.5;
b=1;
ug=get_spab(N,m,c,b)
model=system_simulator(index,ug')
arx_model=arx(model,[15,15,1]);
figure,compare(arx_model,data);
%data=system_simulator(index,u)

function spab=get_spab(N,m,c,b) %semal pseudo-aleator binar

a=zeros(1,m);
x=zeros(1,m);

if(m==3)
a(1)=1;
a(3)=1;
x(2)=1;
end

if(m==4)
a(1)=1;
a(4)=1;
x(3)=1;
end

if(m==5)
a(2)=1;
a(5)=1;
x(4)=1;
x(3)=1;
end

if(m==6)
a(1)=1;
a(6)=a(1);
x(2)=1;
end

if(m==7)
a(1)=1;
a(7)=a(1);
x(3)=1;
end

if(m==8)
a(1)=1;
a(2)=a(1);
a(7)=a(1);
a(8)=a(1);
x(3)=1;
x(4)=1;
end

if(m==9)
a(4)=1;
a(9)=a(4);
x(1)=1;
x(2)=1;
end

if(m==10)
a(3)=1;
a(10)=a(3);
x(1)=1;
x(3)=3;
end

u=zeros(1,N);

for i=1:N
fzf=[eye(m-1) zeros(m-1,1)] %
X=mod([a;fzf]*x',2);% generare matrice 
u(i)=X(end); % [0 0 0 0 ... 1] * x(i)
spab(i)=b+(c-b)*u(i); %scalare semnal
x=X';
end

end




