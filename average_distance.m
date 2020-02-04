function [dis] = average_distance(x, y)
    n = size(x, 2);
    dis = 0;
    for i = 1:n-1
        dis = dis + sqrt((x(i + 1) - x(i))^2 + (y(i + 1) - y(i))^2);
    end
    dis = dis + sqrt((x(1) - x(n))^2 + (y(1) - y(n))^2);
    dis = dis/n;
end

