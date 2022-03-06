m=3;
b=0.5;
c=1;
N=300

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

x=[];

for i=1:N
X=mod([a;eye(m-1),zeros(m-1)]*x,2);
u(i)=X(end);
spab=b+(c-b)*u(i);
x=X';
end