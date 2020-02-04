function [Fx, Fy] = Fairing(x, y, ratio, theta)
    n = size(x, 2);
    Fx = zeros(1, n);
    Fy = zeros(1, n);
    for i = 1:n
%         if i == 1
%             Fx(1) = ratio*(0.5*(x(n) + x(2)) - x(1));
%             Fy(1) = ratio*(0.5*(y(n) + y(2)) - y(1));
%         elseif i == n
%             Fx(n) = ratio*(0.5*(x(n - 1) + x(1)) - x(n));
%             Fy(n) = ratio*(0.5*(y(n - 1) + y(1)) - y(n));
%         else
%             Fx(i) = ratio*(0.5*(x(i - 1) + x(i + 1)) - x(i));
%             Fy(i) = ratio*(0.5*(y(i - 1) + y(i + 1)) - y(i));
%         end
        if i == 1
            if ((x(1) - x(n))*(x(1) - x(2)) + (y(1) - y(n))*(y(1) - y(2)))/sqrt((x(1) - x(n))^2 + (y(1) - y(n))^2)/sqrt((x(1) - x(2))^2 + (y(1) - y(2))^2) > cos(theta)
                Fx(1) = ratio*(0.5*(x(n) + x(2)) - x(1));
                Fy(1) = ratio*(0.5*(y(n) + y(2)) - y(1));
            end
        elseif i == n
            if ((x(n) - x(n - 1))*(x(n) - x(1)) + (y(n) - y(n - 1))*(y(n) - y(1)))/sqrt((x(n) - x(n - 1))^2 + (y(n) - y(n - 1))^2)/sqrt((x(n) - x(1))^2 + (y(n) - y(1))^2) > cos(theta)
                Fx(n) = ratio*(0.5*(x(n - 1) + x(1)) - x(n));
                Fy(n) = ratio*(0.5*(y(n - 1) + y(1)) - y(n));
            end
        else
            if ((x(i) - x(i - 1))*(x(i) - x(i + 1)) + (y(i) - y(i - 1))*(y(i) - y(i + 1)))/sqrt((x(i) - x(i - 1))^2 + (y(i) - y(i - 1))^2)/sqrt((x(i) - x(i + 1))^2 + (y(i) - y(i + 1))^2) > cos(theta)
                Fx(i) = ratio*(0.5*(x(i - 1) + x(i + 1)) - x(i));
                Fy(i) = ratio*(0.5*(y(i - 1) + y(i + 1)) - y(i));
            end
        end
    end

end

