load('lab9_1.mat')

u_id = id.u;
y_id = id.y; %date identificare

na=n; % am primit ordin 2
nb=n;
nk=1;

Theta=zeros(na+nb,na+nb);
Y=[na+nb,1];

q=1;
C=1;
D=-q^(-nb);
model = iv(id, [na, nb, nk], C, D);
ARX=arx(id, [na nb nk]);
compare(model,val,ARX);
legend(AutoUpdate="on");