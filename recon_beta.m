function mu_est = recon_beta(q,T_est,K,lambda)
% reconstructs a measure given beta-quantized Fourier coefficients,
% estimated support set T_est, and parameters

if isempty(T_est)
    mu_est = [];
else
    m = length(q);      % number of samples
    Omega = 0:(m-1);
    F_est = exp(-1i*2*pi*Omega'*T_est');    % estimated Fourier matrix
    
    beta = K*(lambda-1)/lambda;
    w1 = 1-beta^(-lambda)*exp(-2*pi*1i*T_est*m*lambda);
    w2 = 1-beta^(-1)*exp(-2*pi*1i*T_est*m);
    w = w1./w2;
    x_est = (F_est\q)./w;  % least squares solution and reweight
    mu_est = [T_est,x_est];
end

