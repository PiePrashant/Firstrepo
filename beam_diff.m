clc;
%%% Calculation of E, and clamped force,torque
data = xlsread("1stbeam","sheet3");

for q = 1:3
%%% Input section

L = 1.225;  % length of beam
B = 0.0653;  % width of beam
H = 0.01; % height of beam
Leff = 1.225;   % hanging length
weight =9.24; % weight of beam
P = data(16,10:12);   % applied external load (point load)


%%% calculating basic parameters

I = B * H^3 /12;        %  Second momoent of area 
w = weight * 9.81 / L;  % uniform distributed load
xlen = data(2:14,9);     % different points on x axis
def = data(2:14,9+q);    % deflection at that respectiive points

%%% solving differential equation

syms y(x) E C29 C30 C31 C32
eqn = diff(y,x,4) == w/(E*I);   % beam deflection equation of motion
if q == 1  %% for no load condition
    cond = [y(xlen(13))==def(13),y(xlen(8))==def(8),y(xlen(5))==def(5),y(xlen(2))==def(2)];
    y = dsolve(eqn,cond);
else       %% for end load condition, I have satisfied load condition while finding unknowns
    y = dsolve(eqn)    %% eqn with four unknowns C23,C24,C25 and C26
    force = diff(y,x,3); %% d3y/dx3 = force
    
    moment =diff(y,x,2);  %% d2y/dx2 = moment
    temp1= solve(subs(force,x,xlen(end))==P(q),C29)  %solving to find C23
    temp2 = solve(subs(moment,x,xlen(end))==0,C30)   %solving to find C24
    temp3 = subs(temp2,C29,temp1)   % %% C24 in terms of C23
    y = subs(y,[C29,C30],[temp1,temp3]) %% y in terms of C25 and C26  only
    [temp1, temp2] = solve([ subs(y,x,xlen(3))==def(3), subs(y,x,xlen(5))==def(5) ], [C31,C32]);   %solving to find C25 and C26
    y = subs(y,[C31,C32],[temp1,temp2]);   %% y in terms of E only
    
    
    
end
E= solve( subs(y,x,xlen(6))==def(6),E);  %solving for E
slope = diff(y,x);
moment = diff(y,x,2);
force = diff(y,x,3);
moment = matlabFunction(moment);
moment0(q) = double(moment(E,0));
force = matlabFunction(force);
force0(q) = double(force(E,0));
slope = matlabFunction(slope);
slope0(q) = double(slope(E,0));
deflection = matlabFunction(y);
deflection0(q) = double(deflection(E,0));
Kx(q) = double(-force0(q) / deflection0(q));
Kt(q) = double(moment0(q)/ slope0(q));
modulus(q) = E;

end
disp("Load = "+ num2str(P))
youngs_modulus = double(modulus)
disp("Kt = " + num2str(double(Kt)))
disp("Kx = "+ num2str(double(Kx)))
disp("force0 = "+ num2str(double(force0)))
disp("moment0 = "+ num2str(double(moment0)))

