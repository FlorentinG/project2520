%Makes a little animation for the speed in two spatial dimension (we no
%long consider that the height of the cylinder is infinite)
%
%Goyens Florentin & Weicker David
close all;
clear all;

Nr = 10;
Nt = 100;
tend = 200;

ht = tend/Nt;
[U,r,z,t] = nsCyl(Nr,Nt,tend);

n = Nt+1;
for i=1:n
    titre = sprintf('Time t=%f',(i-1)*ht);
    contourf(r,z,U(:,:,i),0:0.005:0.04);colorbar;caxis([0 0.04]);
    title(titre);xlabel('r [m]');ylabel('z [m]');axis equal;
    F(i) = getframe(gcf);
end
movie(F);
movie2avi(F,'anim2D','compression','None');