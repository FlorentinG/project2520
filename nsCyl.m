function [] = nsCyl(Nr,Nt,tend)
%NSCYL 
nu = 1e-6;
omega = 1;
R = 0.04;
H = 0.08;

h = R/Nr;
r = 0:h:R;
z = 0:h:H;
Nz = length(z)-2;
alpha = nu/(h*h);

e = zeros(Nr*Nz,1);
for i=0:Nz-1
    e(1+i*Nr:(i+1)*Nr) = (1:Nr)';
end
display(e);

a = ones(Nr*Nz,1);
b = 1-1./(2*(e));
c = -4-1./(e.*e);%SOLVE THIS PROBLEM OF SHIFTING
d = 1+1./(2*(e));
A = spdiags([a b c d a],[-Nr -1 0 1 Nr],Nr*Nz,Nr*Nz);
display(full(A));

end

