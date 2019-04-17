
clear all
n=[4,8,16,32,64,128];
b=1.2;a=0;
I=double(4*atan(1.2));
f=@(x) 4/(1+x^2);
for i=1:length(n)
    delx=double((b-a)/n(i));
    temp=0;
    %% trapezoid rule
    for j=1:n(i)
        I_n1(j)=double((f(temp)+f(temp+delx))*delx/2);
        temp=temp+delx;
    end
    I_n(i)=double(sum(I_n1));
    e_n(i)=I-I_n(i);
    
    
end
error_ratio=e_n(2:6)./e_n(1:5);
for i=1:5
E_ht(i)=double((4/3)*(I_n(i+1)-I_n(i)));
fprintf('Richardsons error estimateof n=%.0f:%f \n',[n(i+1) E_ht(i)])
end

for i=3:5
E_ht2(i-2)=(double(1/3)*(I_n(i+1)-I_n(i)));
end
for i=1:3
fprintf('%1.14f \n',I_n(i+2)+E_ht2(i)) %extrapolated values
end
    
    