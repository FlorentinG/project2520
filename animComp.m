function [] = animComp(height)
%ANIMCOMP Makes an animation to compare the solution at differents heights 
%with the solution obtained for an infinite height
%INPUT : height is a vector containing the heights we want to compare
%
%Goyens Florentin & Weicker David
close all;

Nr = 9;
h = 0.04/(Nr+1);
Nt = 100;
tend = 200;
Z = round(height/h)+1;

M{1} = 'Infinite height';
for i = 2:length(height)+1
    M{i} = sprintf('z = %f',height(i-1));
end

ht = tend/Nt;
[U,~,~,~] = nsCyl(Nr,Nt,tend);
[u,r,~] = highCyl(Nr,Nt,tend);

n = Nt+1;
for i=1:n
    titre = sprintf('Time t=%f',(i-1)*ht);
    plot(r,u(i,:),r,U(Z,:,i));
    title(titre);xlabel('r [m]');ylabel('Speed [m/s]');axis([0 0.04 0 0.04]);legend(M);
    F(i) = getframe(gcf);
end
movie2avi(F,'animCom','compression','None');
end

