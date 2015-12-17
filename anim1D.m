%Makes a little animation in 1D
close all;
clear all;

Nx = 20;
Nt = 200;
tend = 200;

ht = tend/Nt;
[U,r,t] = highCyl(Nx,Nt,tend);

n = Nt+1;
for i=1:n
    titre = sprintf('Time t=%f',(i-1)*ht);
    plot(r,U(i,:));
    title(titre);xlabel('r [m]');ylabel('Speed [m/s]');axis([0 0.04 0 0.04]);
    F(i) = getframe(gcf);
end
movie2avi(F,'anim1D','compression','None');