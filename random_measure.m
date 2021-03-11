function mu = random_measure(Delta,p)
% generates a randomly selected measure where
% support set has min separation = Delta
% amplitudes are normalized to have l^p norm = 1

boo = true;
T = [0, Delta];

while boo
    new = T(end)+Delta+abs(normrnd(0,Delta));
    if new > 1-Delta
        boo = false;
    else
        T = [T, new];
    end
end
S = length(T);

% amplitudes with random sign
x = exp(2*pi*1i*rand(S,1));
x = x/norm(x,p);

% measure 
mu(:,1) = T;
mu(:,2) = x;
