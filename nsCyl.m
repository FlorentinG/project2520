function [U,r,z,t] = nsCyl(Nr,Nt,tend)
%NSCYL 
nu = 1e-6;
omega = 1;
R = 0.04;
H = 0.08;

h = R/(Nr+1);
r = 0:h:R;
z = 0:h:H;
Nz = length(z)-2;
alpha = nu/(h*h);

e = zeros(Nr*Nz,1);
for i=0:Nz-1
    e(1+i*Nr:(i+1)*Nr) = (1:Nr)';
end

%Construction of A and B
a = ones(Nr*Nz+1,1);
b = [1-1./(2*e(2:end)); 0; 0];
c = [-4-1./(e.*e); 0];
d = [0; 1+1./(2*e)];
A = alpha*spdiags([a b c d a],[-Nr -1 0 1 Nr],Nr*Nz,Nr*Nz);
B = zeros(Nr*Nz,1);
for m = 1:Nz-1
    A(Nr*m,Nr*m+1) = 0;
    A(1+m*Nr,m*Nr) = 0;
    B(m*Nr) = alpha*(1+1/(2*Nr))*R*omega;
end
B(Nz*Nr) = B(Nz*Nr) + alpha*(1+1/(2*Nr))*R*omega;
for m = 1:Nr
    B(m) = B(m) + nu*omega*m/h;
    B(m+(Nz-1)*Nr) = B(m+(Nz-1)*Nr) + nu*omega*m/h;
end

U = zeros(Nz+2,Nr+2,Nt+1);
U(:,:,1) = omega*ones(Nz+2,1)*r;
u = zeros(Nr*Nz,Nt+1);
u(:,1) = reshape(U(2:end-1,2:end-1,1)',Nr*Nz,1);

deltaT = tend/Nt;
t = 0:deltaT:tend;
%First iteration
I = eye(Nr*Nz);
u(:,2) = (I-0.5*deltaT*A)\((I+0.5*deltaT*A)*u(:,1)+0.5*deltaT*B);
U(2:end-1,2:end-1,2) = reshape(u(:,2),Nr,Nz)';

%Following iterations
for i = 2:Nt
    u(:,i+1) = (I-0.5*deltaT*A)\((I+0.5*deltaT*A)*u(:,i));
    U(2:end-1,2:end-1,i+1) = reshape(u(:,i+1),Nr,Nz)';
end
end

