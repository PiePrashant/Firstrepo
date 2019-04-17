function [ maxim,flag ] = myMax( x )
if isrow(x) 
   x = x';
end
[m,n] = size(x);
for i=1:n
    flag(i) = 1;
    maxim(i) = x(1,i);
    for j =2:m
        if x(j,i) > maxim(i)
            maxim(i) = x(j,i);
            flag(i) = j;
        end
    end
end



end

