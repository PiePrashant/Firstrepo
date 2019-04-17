clc;
%%% Calculation of E, and clamped force,torque
data = xlsread("1stbeam","sheet1");
for q=1:1
%%% Input section
syms E kt kq  thita0 x0


L = 1.266;  % length of beam
B = 0.0842;  % width of beam
H = 0.00324; % height of beam
Leff = 1.052;   % hanging length
weight = 2.48; % weight of beam in kg
P = data(11,10:12);   % applied external load (point load)
l = Leff/7;

%%% calculating basic parameters

I = B * H^3 /12;        %  Second momoent of area 
w = weight * 9.81 / L;  % uniform distributed load
xlen = data(2:9,9);     % different points on x axis
def = data(2:9,9+q);    % deflection at that respectiive points

k = [12 6*l -12 6*l;
    6*l 4*l*l -6*l 2*l*l;
    -12 -6*l 12 -6*l;
    6*l 2*l*l -6*l 4*l*l];
cons = E*I/(l^3);
f = [w*l/2 -(w*l^2)/12 w*l/2 (w*l^2)/12]';

f_global = zeros(16,1);
k_global = zeros(16,16);
u = zeros(16,1);
for i =1:7
k_global(2*i-1:2*i+2,2*i-1:2*i+2) = k_global(2*i-1:2*i+2,2*i-1:2*i+2) + k;
f_global(2*i-1:2*i+2) = f_global(2*i-1:2*i+2) + f;
u(2*i-1) = def(i);


end
u(15) = def(end);
f_global(end) = f_global(end) - P(q);



f_global_new(1) = f_global(1) + kt*x0;
f_global_new(2) = f_global(2) + kq*thita0;
for i=1:14
f_global_new(i+2) = f_global(i+2);
end

if iscolumn(f_global_new) == 0
    f_global_new = f_global_new';
end

u_new(1) = u(1) + x0;
u_new(2) = u(2) + thita0;


for i =1:7
    u_new(2*i+1) = u(2*i+1);
end


for i =1:7
    u_new(2*i+2) = u_new(2) + ((u_new(2*i) - u_new(i))/l);
end


if iscolumn(u_new) == 0
    u_new = u_new';
end



% 5 unknowns  16 equations
temp = cons .* (k_global * u_new);

% solving equation
eqn1 = f_global_new(1) == temp(1);
eqn2 = f_global_new(2) == temp(2);
eqn3 = f_global_new(6) == temp(6);
eqn4 = f_global_new(10) == temp(10);
eqn5 = f_global_new(16) == temp(16);

[kt kq x0 thita0 E] = solve([eqn1, eqn2, eqn3, eqn4, eqn5],[kt kq x0 thita0 E]);

double(E)
double([kt kq x0 thita0])

end




















 
 
