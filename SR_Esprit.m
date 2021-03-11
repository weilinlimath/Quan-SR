function T_est = SR_Esprit(q,S)
% produces an estimate of the support of an unknown measure given
% q are noisy Fourier coefficients of the measure
% par.S is the sparsity of the measure
% par.ep is an upper bound for the ell^2 norm of the quantization noise
% par.tol is the tolerance for numerical errors

m = length(q);  % number of samples
l = floor(m/2); % Hankel matrix parameter

% create Hankel matrix
H = zeros(l,m-l+1);
for jj = 1:l
    H(jj,:) = q(jj:m-l+jj);
end
[U,~,~] = svd(H);

% reformulate as an eigenvalue problem
U0 = U(1:(l-1),1:S);
U1 = U(2:l,1:S);
Psi = pinv(U0)*U1;
T_est = angle(conj(eig(Psi)));

% remap to the torus
ind = find(T_est<0);
T_est(ind) = T_est(ind)+2*pi;
T_est = sort(T_est)/(2*pi);