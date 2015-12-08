% Task 1 Project 
% Florentin GOYENS and David WEICKER
% Solves the problem with 1D approximation in space variables
%
clear all;
close all;

% Parameters
nu = 1e-6;
omega = 1;
% Space grid
Nx = 12; 
R = 0.04;
hx = R/(Nx+1);
r = linspace(hx,R-hx,Nx)';
% Time grid
Nt = 100; 
Tend = 200;
T0 = 0;
ht = (Tend-T0)/(Nt-1);
t = linspace(T0,Tend,Nt)';


U = zeros(Nx,Nt);
U(:,1) = omega*r;

e = ones(Nx,1);
a =  nu*(1/hx - 1./r).*e/hx;
b = -nu*(2/(hx*hx) + 1./(r.*r)).*e;
c =  nu*(1/hx + 1./r).*e/hx;
A = spdiags([a b c],[-1 0 1],Nx,Nx);
I = speye(Nx,Nx);

%
% first step 
%

% Euler explicit
% U(:,2) = U(:,1) + ht*(A*U(:,1) + [zeros(Nx-1,1); nu*R*(1/r(end) + 1/hx)/hx]);
% Crank-Nicolson
U(:,2) = (I - 0.5*ht*A)\((I+0.5*ht*A)*U(:,1)+[zeros(Nx-1,1); nu*R*(1/r(end) + 1/hx)/hx]);

%
% following steps
%
for i = 3:Nt
    % Euler explicit
    %     U(:,i) = U(:,i-1) + ht*A*U(:,i-1); % stable ?
    
    % Crank-Nicolsons
    U(:,i) = (I - 0.5*ht*A)\((I+0.5*ht*A)*U(:,i-1));                                
end

% BC application
U = [zeros(1,Nt); 
    U; 
    omega*R, zeros(1,Nt-1)];
r = [0; r; R];
% now length(r) = Nx + 2 and size(U) = (Nx+2)xNt

figure();
axis equal;
surf(t,r,U); ylabel('radius r'); xlabel('time t'); 
title('Fluid velocity in cylinder');
