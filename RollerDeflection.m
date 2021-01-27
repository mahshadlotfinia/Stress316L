%Created on October 2020.
% roll deflection calculation using Finite Element method.

%@author: Mahshad Lotfinia <mahshad.lotfinia@alum.sharif.edu>
%https://github.com/mahshadlotfinia/
%%

clc
clear
close all

L = 0.2000;
% E = 210e9;
E1 = 211e9;
E2 = 211e9;
%b = 0.01;
%h = 0.01;
r=0.075;
d=2*r;
A = pi*(r^2);
I = (pi*(d^4))/64;
F0 = input('main pressure');

x1 = 0.075;
x2 = 0.045;

N = input('number of elements');
x = linspace(0,L,N);
l = x(2) - x(1);

NS = floor(x1/l)+1;
NE = floor((x1+x2)/l)+1;

Ke = [  12/l^3,  6/l^2, -12/l^3,  6/l^2
         6/l^2,    4/l,  -6/l^2,    2/l
       -12/l^3, -6/l^2,  12/l^3, -6/l^2
         6/l^2,    2/l,  -6/l^2,    4/l];
     
Fe = l/2*[1
          0
          1
          0];

W = zeros(N,1);
T = zeros(N,1);
KT = zeros(2*N,2*N);
FT = zeros(2*N,1);

for i = 1:N-1
    
    E = (E2-E1)/(N-1)*(i-1)+E1;
    KT(2*i-1:2*(i+1),2*i-1:2*(i+1)) = KT(2*i-1:2*(i+1),2*i-1:2*(i+1)) + E*I*Ke;
    
end

for i = NS:NE
    
    % FT(2*i-1:2*(i+1),1) = FT(2*i-1:2*(i+1),1) + F0*(i-NS)/(NE-NS)*Fe;
    FT(2*i-1:2*(i+1),1) = FT(2*i-1:2*(i+1),1) + F0*Fe;
    
end

KT(1,:) = 0;
KT(:,1) = 0;
KT(1,1) = 1;

KT(2,:) = 0;
KT(:,2) = 0;
KT(2,2) = 1;

KT(2*N-1,:) = 0;
KT(:,2*N-1) = 0;
KT(2*N-1,2*N-1) = 1;

 KT(2*N,:) = 0;
 KT(:,2*N) = 0;
 KT(2*N,2*N) = 1;

X = KT^-1*FT;

for i = 1:N
    
    W(i) = X(2*i-1);
    T(i) = X(2*i);
    
end

figure
plot(x,W)
grid on
xlabel('x')
ylabel('w')

figure
plot(x,T)
grid on
xlabel('x')
ylabel('Slope')
