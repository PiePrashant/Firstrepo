         %%%%%%     15NA30014 ||  Prashant Kumar    %%%%%%%%%
clear all;
clc;
m=14; k=121; w=sqrt(k/m);
z=[0 0.02 1 1.2];  %%    z=zita

         %%%%% zita=0  undamped oscillation

syms x0 v0 t c1 c2
x=@(t,v0,x0)x0*cos(w*t)+(v0/w)*sin( w*t);
v=diff(x,t);
v=matlabFunction(v);
a(t)=diff(v,t);
a=matlabFunction(a);
t1=[0:0.025:4*pi/w];

    x0=-0.5;  v0=1;

           for q=1:length(t1)
           x11(q)=x(t1(q),v0,x0);
           v11(q)=v(t1(q),v0,x0);
           a11(q)=a(t1(q),v0,x0);
  end   
  
%   plot(t1,x11,t1,v11,t1,a11)
%   legend('disp','vel','accn')
%   title('undamped oscillation ')
%   xlabel('--0<  t  <4*pi/w--')
%   figure;
%   plot(x11,v11/w)

            %%%%%%%%%%  z=0.02   subcritical damping

wd=w*sqrt(1-z(2)*z(2));
c2=((v0+z(2)*w*x0)/wd);
x=@(t,v0,x0)exp(-z(2)*w*t)*(x0*cos(wd*t)+((v0+z(2)*w*x0)/wd)*sin(wd*t));
v=diff(x,t);
v=matlabFunction(v);
a=diff(v,t);
a=matlabFunction(a);
t1=[0:0.025:4*pi/wd];

               %%% Conditions

    x0=-0.5;  v0=1;

        for q=1:length(t1)
        x22(q)=x(t1(q),v0,x0);
        v22(q)=v(t1(q),v0,x0);
        a22(q)=a(t1(q),v0,x0);
  end   
%   figure
%   plot(t1,x22,t1,v22,t1,a22)
%   legend('disp','vel','accn')
%   title('damped oscillation ')
%   xlabel('--0<  t  <4*pi/wd--')
%   figure
%   plot(x22,v22/wd)
   
             %%%%%%%%%%  z=1  critical damping 
  
  x=@(t,v0,x0)exp(-w*t)*((v0+w*x0)*t+x0);
  v=diff(x,t);
  v=matlabFunction(v);
  a=diff(v,t);
  a=matlabFunction(a);
  t1=[0:0.025:4*pi/w];
  
                      %%% Conditions

  x0=-0.5;  v0=1;

        for q=1:length(t1)
         x33(q)=x(t1(q),v0,x0);
         v33(q)=v(t1(q),v0,x0);
         a33(q)=a(t1(q),v0,x0);
        end   
%    figure
%   plot(t1,x33,t1,v33,t1,a33)
%   legend('disp','vel','accn')
%   title('critically damped oscillation ')
%   xlabel('--0<  t  <4*pi/w--')
%   figure;
%   plot(x33,v33/w);
  
            %%%%%%%%%%  z=1  supercritical damping 
  
  ws=w*sqrt((z(4)*z(4))-1);
  x=@(t,v0,x0)(((v0+z(4)*w*x0+wd*x0)/2*wd)*exp(-z(4)*w*t+wd*t))+(((-v0-z(4)*w*x0+wd*x0)/2*wd)*exp(-z(4)*w*t-wd*t));
  v=diff(x,t);
  v=matlabFunction(v);
  a=diff(v,t);
  a=matlabFunction(a);
  t1=[0:0.025:4*pi/wd];
  
  x0=1;  v0=0;

        for q=1:length(t1)
          x44(q)=x(t1(q),v0,x0);
          v44(q)=v(t1(q),v0,x0);
          a44(q)=a(t1(q),v0,x0);
        end   
  figure
  plot(t1,x44,t1,v44,t1,a44)
  legend('disp','vel','accn')
  title('supercrictical damped oscillation ')
  xlabel('--0<  t  <4*pi/wd--')
  figure
  plot(x44,v44/wd)
  
  
   