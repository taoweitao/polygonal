function [Bx, By] = Brownian(n, mu, sigma)
    Bx = normrnd(mu, sigma, 1, n);
    By = normrnd(mu, sigma, 1, n);
end

