function error = compute_error(mu,mu_est,m,method)
% computes the error between the true measure (T,x) and the estimated one
% (T_est,x_est)

T = mu(:,1);
x = mu(:,2);

if isempty(mu_est) 
    error = norm(x);
else 
    T_est = mu_est(:,1);
    x_est = mu_est(:,2);

    if ~(length(T)==length(T_est))
       disp(['Warning: exact and estimated number of atoms are not equal, ',method])
    end

    error = zeros(length(T),1);     % initialize
    C = 0.1649;     % numerical constant
    ind_total = [];
    ind_set = 1:length(T_est);
    
    for jj = 1:length(T)
        ind = (abs(T_est-T(jj))<C/m) | (1-abs(T_est-T(jj))<C/m);
        if nnz(ind) ~= 1
            disp('Warning: mismatch between exact and estimated atoms')
        end
        ind_total = [ind_total, ind_set(ind)];
        %error = error + sum(abs(T(jj)-T_est(ind).^p)) + sum(abs(x(jj)-x_est(ind).^p));
        error(jj) = abs(x(jj)-sum(x_est(ind)));
    end
    ind_total = sort(unique(ind_total));
    spur = abs(x_est);
    spur(ind_total) = [];
    error(end+1) = norm(spur,1);
    error = max(error);
end