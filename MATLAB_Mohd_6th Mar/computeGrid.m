function [ v ] = computeGrid( low,high )
c = [1 2 5];
k = 0;
M = c(1) * 10^k;
    while true
        for i=1:3
            if low + 8 * M > high  || high - 3 * M < low
                break
            else 
                M = c(i) * 10^k;
            end
        end
        if low + 8 * M > high  || high - 3 * M < low
            break
        else 
            k = k + 1;
            M = c(1) * 10^k;
        end
    end 
if mod(low,M) == 0
    ret(1) =low - M;
else
    ret(1) =low - mod(low,M);
end
j=1;
    while ret(j) <= high
       ret(j+1) = ret(j) + M;
        j = j + 1;
    end
    v = ret; 
end
