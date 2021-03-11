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
    %plot(Lambda(1:6),log10(es_msq_worst(1:6,kk)),'--*','Color',colors(kk-1,:),'LineWidth',linewidth,'DisplayName',['MSQ K=',num2str(Levels(kk))])
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
str = ['ESPRIT_lambda_',num2str(trials),'_trials'];
ylim([-5,0])
saveas(gcf,str)

%%

figure;
hold on
for kk = 1:length(Levels)
    plot(Lambda,log10(es_msq_worst(:,kk)),'--*','Color',colors(kk,:),'LineWidth',linewidth,'DisplayName',['MSQ K=',num2str(Levels(kk))])
    plot(Lambda,log10(es_beta_worst(:,kk)),'-*','Color',colors(kk,:),'LineWidth',linewidth,'DisplayName',['Beta K=',num2str(Levels(kk))])
end
hold off
title(['ESPRIT: Accuracy for MSQ and Beta over ',num2str(trials),' trials'])
xlabel('Over sampling ratio \lambda')
ylabel('Log_{10}(reconstruction error)')
legend('Location','Southwest')
set(gca, 'XTick', Lambda)
set(gca,'FontSize',12)
ylim([-8,0])
str = ['ES_lambda_',num2str(trials),'_trials'];
saveas(gcf,str)

%%

figure;
hold on
for kk = 1:length(Lambda)
    plot(log2(Levels),log2(es_msq_worst(kk,2:8)),'--*','Color',colors(kk,:),'LineWidth',linewidth,'DisplayName',['MSQ \lambda=',num2str(Lambda(kk))])
    plot(log2(Levels),log2(es_beta_worst(kk,2:8)),'-*','Color',colors(kk,:),'LineWidth',linewidth,'DisplayName',['Beta \lambda=',num2str(Lambda(kk))])
end
hold off
title(['ESPRIT: Accuracy for MSQ and Beta over ',num2str(trials),' trials'])
xlabel('Log_2(K)')
ylabel('Log_2(reconstruction error)')
legend('Location','Southwest')
set(gca,'FontSize',12)
ylim([-22,0])
str = ['ESPRIT_levels_',num2str(trials),'_trials'];
saveas(gcf,str)

%%

figure;
hold on
for kk = 1:length(Lambda)
    plot(log2(Levels),log2(tv_msq_worst(kk,2:8)),'--*','Color',colors(kk,:),'LineWidth',linewidth,'DisplayName',['MSQ \lambda=',num2str(Lambda(kk))])
    plot(log2(Levels),log2(tv_beta_worst(kk,2:8)),'-*','Color',colors(kk,:),'LineWidth',linewidth,'DisplayName',['Beta \lambda=',num2str(Lambda(kk))])
end
hold off
title(['TV-min: Accuracy for MSQ and Beta over ',num2str(trials),' trials'])
xlabel('Log_2(K)')
ylabel('Log_2(reconstruction error)')
legend('Location','Southwest')
set(gca,'FontSize',12)
ylim([-22,0])
str = ['TV_levels_',num2str(trials),'_trials'];
saveas(gcf,str)
