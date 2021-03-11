function mu_est = recon_msq(q,T_est)
% reconstructs a measure given MSQ Fourier coefficients q

if isempty(T_est)
    mu_est = [];
else
    m = length(q);      % number of samples
    Omega = 0:(m-1);
    F_est = exp(-1i*2*pi*Omega'*T_est');    % estimated Fourier matrix
    x_est = F_est\q;        % least squares solution
    mu_est = [T_est,x_est];
end