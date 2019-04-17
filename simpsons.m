clc
clear all
n=[4,8,16,32,64,128];
b=1.2;a=0;
I=4*atan(1.2);
f=@(x) 4/(1+x^2);
for i=1:length(n)
    delx=(b-a)/n(i);
    temp=0;
    %% simpson rule
    j=1;
    while temp<=b
        I_n1(j)=(f(temp)+4*f(temp+delx)+f(temp+2*delx))*delx/3;
        temp=temp+2*delx;
        j=j+1;
    end
    
    I_n(i)=sum(I_n1);
    e_n(i)=I-I_n(i);
    
end
error_ratio=e_n(2:6)./e_n(1:5)
for i=1:5
E_hs(i)=(double(16/15)*(I_n(i+1)-I_n(i)));
fprintf('Richardsons error estimateof n=%.0f:%f \n',[n(i+1) E_hs(i)])
end

    
for i=3:5
E_hs2(i-2)=(double(1/15)*(I_n(i+1)-I_n(i)));
end
for i=1:3
fprintf('%1.14f \n',I_n(i+2)+E_hs2(i)) %extrapolated values
end
    