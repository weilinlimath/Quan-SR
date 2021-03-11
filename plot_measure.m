function plot_measure(mu,mu_est,par,method)

%% plot results

T = mu(:,1);
x = mu(:,2);
markersize = 7;
linewidth = 2;

figure;

subplot(1,2,1);
stem(T,real(x),'fill','or','Color','red','MarkerSize',markersize,'LineWidth',linewidth)
if ~isempty(mu_est)
    hold on
    T_est = mu_est(:,1);
    x_est = mu_est(:,2);
    stem(T_est,real(x_est),'or','Color','blue','MarkerSize',markersize,'LineWidth',linewidth)
    hold off
end
title('Real part')
xlim([0 1])
ylim([-1 1])
legend('Exact','Estimated','Location','Southeast')
set(gca,'FontSize',18)
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])

subplot(1,2,2);
stem(T,imag(x),'fill','or','Color','red','MarkerSize',markersize,'LineWidth',linewidth)
if ~isempty(mu_est)
    hold on
    T_est = mu_est(:,1);
    x_est = mu_est(:,2);
    stem(T_est,imag(x_est),'or','Color','blue','MarkerSize',markersize,'LineWidth',linewidth)
    hold off
end
title('Imaginary part')
xlim([0 1])
ylim([-1 1])
legend('Exact','Estimated','Location','Southeast')
set(gca,'FontSize',18)
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])

sgtitle(['Reconstructed measure using ',method,' with \lambda=',num2str(par.lambda),' and K=',num2str(par.K)])
set(gca,'FontSize',18)

%print -f1 -depsc real_part.png
