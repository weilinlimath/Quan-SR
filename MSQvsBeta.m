% Super-resolution via ESPRIT and TV_min
% Comparison between MSQ and beta-encoding method

%% set up
clear all
close all
% delete(gcp('nocreate'))

%%

% Experiment parameters
trials = 50;            % number of trials
Delta = 0.15;           % minimum separation
Levels = 1+2.^(3:7);    % number of uniform quantization levels
Lambda = 2:7;           % oversampling ratio
m = ceil(4/Delta);      % minimum number of samples
alpha = 1;              % upper bound for the size of each measurement
tol = 1e-4;             % numerical error tolerance

%%

% Quantization methods
es_msq = zeros(length(Lambda),length(Levels),trials);
es_beta = zeros(size(es_msq));
tv_msq = zeros(size(es_msq));
tv_beta = zeros(size(es_msq));
measure = cell(trials,1);   % cell with all randomly generated measures
measure_est = cell(trials,1);

%%
% Code is compatible with Matlab's parallel for loop
% Create a parallel pool and change the outside for loop into parfor

% parpool(25)
for ll = 1:trials
    
    % create temporary arrays
    temp_es_msq = zeros(length(Lambda),length(Levels));
    temp_es_beta = zeros(length(Lambda),length(Levels));
    temp_tv_msq = zeros(length(Lambda),length(Levels));
    temp_tv_beta = zeros(length(Lambda),length(Levels));
    
    disp(['Trial number ',num2str(ll)])
    
    % randomly selected measure
    mu = random_measure(Delta,1);
    measure{ll} = mu;
    S = size(mu,1);
    
    for jj = 1:length(Lambda)
        
        % oversampling ratio
        lambda = Lambda(jj);
        
        % number of samples with oversampling lambda
        M = m*lambda;
        
        % clean analog measurements
        Omega = 0:(M-1);
        T = mu(:,1);
        x = mu(:,2);
        F = exp(-1i*2*pi*Omega'*T');
        y = F*x;
        
        for kk = 1:length(Levels)
            
            % number of bits
            K = Levels(kk);
            
            % MSQ quantization and reconstruction
            [q,ep] = quan_msq(y,K,alpha);
            
            % ESPRIT
            T_est = SR_Esprit(q,S);
            mu_est = recon_msq(q,T_est);
            temp_es_msq(jj,kk) = compute_error(mu,mu_est,length(q),'ES_MSQ');
            
            % TV-min
            T_est = SR_TV(q,ep,tol);
            mu_est = recon_msq(q,T_est);
            temp_tv_msq(jj,kk) = compute_error(mu,mu_est,length(q),'TV_MSQ');
            measure_est{ll} = mu_est;

            % Beta quantization and reconstruction
            [q,ep] = quan_beta(y,K,m,alpha,lambda);
            
            % ESPRIT
            T_est = SR_Esprit(q,S);
            mu_est = recon_beta(q,T_est,K,lambda);
            temp_es_beta(jj,kk) = compute_error(mu,mu_est,length(q),'ES_Beta');
            
            % TV-min
            T_est = SR_TV(q,ep,tol);
            mu_est = recon_beta(q,T_est,K,lambda);
            temp_tv_beta(jj,kk) = compute_error(mu,mu_est,length(q),'TV_Beta');
            
        end
    end
    
    es_msq(:,:,ll) = temp_es_msq;
    es_beta(:,:,ll) = temp_es_beta;
    tv_msq(:,:,ll) = temp_tv_msq;
    tv_beta(:,:,ll) = temp_tv_beta;
    
end

str = clock;
str = [num2str(str(2)),'_',num2str(str(3)),'_'];
save([str,'results.mat'],'es_msq','es_beta', 'tv_msq','tv_beta')