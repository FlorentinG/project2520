function [] = compare(height)
%COMPARE Plots graphs to compare the solution at differents heights 
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

[u,~,~] = highCyl(Nr,Nt,tend);
[U,r,~,~] = nsCyl(Nr,Nt,tend);
Ntcomp = [1 26 51 76];

figure;
for i = 1:4
    subplot(2,2,i);
    titre = sprintf('Time = %f',tend*(Ntcomp(i)-1)/Nt);
    plot(r,u(Ntcomp(i),:),r,U(Z,:,Ntcomp(i)));xlabel('r [m]');ylabel('Speed [m/s]');
    title(titre);legend(M);
    axis([0 0.04 0 0.04]);
end



end

