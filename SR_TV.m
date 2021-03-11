function T_est = SR_TV(q,ep,tol)
% produces an estimate of the support of an unknown measure given
% q are noisy Fourier coefficients of the measure
% par.ep is an upper bound for the ell^2 norm of the quantization noise
% par.tol is the tolerance for numerical errors

% number of samples
m = length(q);

% Solve SDP formulation
clear X
cvx_solver sdpt3
cvx_precision best
cvx_begin sdp quiet
    variable X(m+1,m+1) hermitian;
    X >= 0;
    X(m+1,m+1) == 1;
    trace(X) == 2;
    for j = 1:m-1
        sum(diag(X,j)) == X(m+1-j,m+1);
    end
    maximize(real(X(1:m,m+1)'*q)-norm(X(1:m,m+1))*ep)
cvx_end

% Fourier coefficients of the dual polynomial
u = X(1:m,m+1);
%plot(abs(u))
%pause 
aux_u = -conv(u,flipud(conj(u)));
aux_u(m) = 1+aux_u(m);
roots_pol = roots(flipud(aux_u));
%plot_dual_poly(u)
%pause 

% Isolate roots on the unit circle
roots_detected = roots_pol(abs(1-abs(roots_pol)) < tol);
[~,ind_sort] = sort(real(roots_detected));
roots_detected = roots_detected(ind_sort);

% plot roots
if false
    figure;
    hold on 
    scatter(real(roots_pol),imag(roots_pol),'filled','blue')
    scatter(real(roots_detected),imag(roots_detected),'red')
    hold off
    title(['\lambda=',num2str(par.lambda),' K =',num2str(par.K)])
    xlim([-1.5,1.5])
    ylim([-1.5,1.5])
end

% Roots are double so take 1 out of 2 and compute argument
T_roots = angle(roots_detected(1:2:end))/(2*pi);

% Argument is between -1/2 and 1/2 so convert angles
T_roots(T_roots < 0) = T_roots(T_roots < 0) + 1;
T_roots = sort(T_roots);

if isempty(T_roots)
    % algorithm failed
    T_est = [];
    disp('Warning: Root finding failed')
else
    % solve primal problem to check duality gap and primal support
    Omega = 0:(m-1);
    F_roots = exp(-2*pi*1i*Omega'*T_roots'); % estimated Fourier matrix
    S_roots = length(T_roots);
    
    cvx_solver sedumi
    cvx_precision best
    cvx_begin quiet
        variable x_roots(S_roots,1) complex;
        minimize(norm(x_roots,1))
        subject to
        norm(q-F_roots*x_roots,2) <= ep
    cvx_end
    
    % treshold small amplitudes and solve linear system
    T_est = T_roots(abs(x_roots) > tol);
    T_est = T_est(:);
end