function [U,r,t] = highCyl(Nx,Nt,tend)
%HIGHCYL Solves the problem in project 8 where the cylinder is considered
%to have infinite height.
%INPUT : - Nx is the number of spatial unknown ==> (Nx+1)*h = R 
%        - Nt is the number of time steps
%        - tend is the final time ==> deltaT*Nt = tend
%OUTPUT : - U is a matrix containing the solution 
%           U(:,i) is the solution for time = t(i)
%         - r is a row vector containing the spatial discretization
%         - t is a row vector containing the time discretization
%
%Goyens Florentin & Weicker David

nu = 1e-6;
omega = 1;
R = 0.04;
h = R/(Nx+1);
alpha = nu/(h*h);

e = (1:Nx)';
a = 1-1./(2*(e+1));
b = -2-1./(e.*e);
c = 1+1./(2*(e-1));
A = alpha*spdiags([a b c],-1:1,Nx,Nx);

U = zeros(Nt+1,Nx+2);
r = 0:h:R;
U(1,:) = omega*r;

deltaT = tend/Nt;
t = 0:deltaT:tend;

%First iteration takes initial condition into account
f = [zeros(1,Nx-1) nu*R*omega*(1/(h*h)+1/(2*h*h*Nx))]';
U(2,2:Nx+1) = (eye(Nx)-0.5*deltaT*A)\((eye(Nx)+0.5*deltaT*A)*U(1,2:Nx+1)'+0.5*deltaT*f);

%Following iterations
for i=2:Nt
    U(i+1,2:Nx+1) = (eye(Nx)-0.5*deltaT*A)\((eye(Nx)+0.5*deltaT*A)*U(i,2:Nx+1)');
end
end

