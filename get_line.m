function [L]=get_line(ru,it,m)
for j=1:m
 L(j)=ru(abs(it-j)+1);
end
end