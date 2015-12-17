%Plot graphs of the solution in one spatial dimension
%
%Goyens Florentin & Weicker David
close all;
clear all;

[U,r,t] = highCyl(10,100,200);
surf(r,t,U);
title('Fluid velocity in cylinder');
xlabel('r [m]');
ylabel('Time [s]');
zlabel('Speed [m/s]');