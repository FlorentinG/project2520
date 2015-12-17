%Makes a little animation for the 2D problem
Nr = 10;
Nt = 100;
tend = 200;

ht = tend/Nt;
[U,r,z,t] = nsCyl(Nr,Nt,tend);

n = Nt+1;
for i=1:n
    titre = sprintf('Time t=%f',(i-1)*ht);
    contourf(r,z,U(:,:,i),0:0.005:0.04);colorbar;caxis([0 0.04]);
    title(titre);xlabel('r [m]');ylabel('Speed [m/s]');axis equal;
    F(i) = getframe;
end
movie(F);