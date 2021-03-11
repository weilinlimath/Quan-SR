%%

linewidth = 2;
markersize = 7;

% Compute the worst
es_msq_worst = max(es_msq,[],3); 
es_beta_worst = max(es_beta,[],3);
tv_msq_worst = max(tv_msq,[],3);
tv_beta_worst = max(tv_beta,[],3);

%es_beta_worst = min(ones(size(es_beta_worst)),es_beta_worst);
%tv_beta_worst = min(ones(size(tv_beta_worst)),tv_beta_worst);

figure
colors = get(gca,'colororder');
close all

%%

figure;
hold on
for kk = 1:3
    plot(Lambda,log10(es_beta_worst(:,kk)),'-*','Color',colors(kk,:),'LineWidth',linewidth,'DisplayName',['ESPRIT K=',num2str(Levels(kk))])
    plot(Lambda,log10(tv_beta_worst(:,kk)),'--*','Color',colors(kk,:),'LineWidth',linewidth,'DisplayName',['TV-min K=',num2str(Levels(kk))])
end
hold off
title(['Coarse beta quantization over ',num2str(trials),' trials'])
xlabel('Over sampling ratio \lambda')
ylabel('Log_{10}(reconstruction error)')
legend('Location','Southwest')
set(gca,'FontSize',12)
set(gca, 'XTick', Lambda)
ylim([-8,0])

%%

figure;
hold on
for kk = 1:3
    plot(Lambda(1:3),log10(es_beta_worst(1:3,kk)),'-*','Color',colors(kk,:),'LineWidth',linewidth,'DisplayName',['ESPRIT K=',num2str(Levels(kk))])
    plot(Lambda(1:3),log10(tv_beta_worst(1:3,kk)),'--*','Color',colors(kk,:),'LineWidth',linewidth,'DisplayName',['TV-min K=',num2str(Levels(kk))])
end
hold off
title(['Coarse beta quantization over ',num2str(trials),' trials'])
xlabel('Over sampling ratio \lambda')
ylabel('Log_{10}(reconstruction error)')
legend('Location','Northeast')
set(gca,'FontSize',12)
set(gca, 'XTick', Lambda)

