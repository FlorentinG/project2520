%Plot graphs of two spatial dimensions for different times
%
%Goyens Florentin & Weicker David
close all;
clear all;

[U,r,z,t] = nsCyl(9,200,200);
j = [0 20 50 100];

figure;
for i=1:4
    subplot(2,2,i);
    contourf(r,z,U(:,:,j(i)+1),0:0.0005:0.04,'edgecolor','None');caxis([0 0.04]);colorbar;
    axis equal;
    title(sprintf('Time=%d',j(i)));xlabel('r [m]');ylabel('z [m]');
end