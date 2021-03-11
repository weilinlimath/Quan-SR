function [q,ep] = quan_beta(y,K,m,alpha,lambda)
% y is the analog complex-valued signal
% K is number of uniform levels
% m is minimum number of samples
% alpha is upper bound on TV of measure
% lambda is the oversampling rate

% initialize
M = m*lambda;
y = y(1:M);
q = zeros(M,1);
u = zeros(M,1);
V = zeros(m,M);

% quantization parameters
beta = K*(lambda-1)/lambda;     % optimal beta
delta = alpha*lambda/K;         % optimal delta
delta2 = 2*delta;

for jj = 1:lambda
    for kk = 1:m
        if jj == 1
            % for the first block
            q(kk) = round((y(kk)-delta)/delta2)*delta2+delta;
            u(kk) = y(kk)-q(kk);
        else
            % for the remaining blocks
            ll = kk+(jj-1)*m;
            q(ll) = round((y(ll)-delta+beta*u(ll-m))/delta2)*delta2+delta;
            u(ll) = y(ll)-q(ll)+beta*u(ll-m);
        end
    end
    V(:,(jj-1)*m+(1:m)) = beta^(-jj+1)*eye(m);
end

q = V*q;
ep = sqrt(2*m)*beta^(-lambda+1)*delta;
