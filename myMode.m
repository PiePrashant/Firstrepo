function [mode,flag ] = myMode( v )

v=sort(v);
count=0;
flag = 0;
mode = v(1);
for i=2:length(v)
    if v(i-1) == v(i)
        count = count + 1;
        if count > flag; 
            mode = v(i);
            flag = count;
        end
    else
        count = 0;
    end
end
flag = flag + 1;

end

