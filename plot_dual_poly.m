function plot_dual_poly(u)
% plots the magnitude of a polynomial on the unit circle with Fourier
% ceofficients given by u

u = u(:);
Omega = 0:(length(u)-1);
x = linspace(0,1,1e4);
F = exp(-2*pi*1i*Omega'*x);
y = F'*u;

linewidth = 2;
figure
plot(x,abs(y),'LineWidth',linewidth)
hold off
xlim([0 1])
ylim([0 1])
title('Magnitude of the dual interpolating polynomial')
set(gca,'FontSize',18)
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])