function [q,ep] = quan_msq(y,K,alpha)
% quantizes a vector y using K levels using MSQ

delta = 2*alpha/(K-1);          % MSQ quantization coarseness
y = y + delta*mod(K+1,2)/2;     % shift by delta/2 if K is even
q = round(y/delta)*delta - delta*mod(K+1,2)/2;
ep = alpha*sqrt(length(y))/K;