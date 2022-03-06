function [s]=my_cov(y,u,tau)
s=0;
for i=1:(length(y)-tau)
 s=s+y(i+tau-1)*u(i);
end
end
