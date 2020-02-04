function [x, y] = point_combine(x, y, ratio, D)
    n = size(x, 2);
    list = [];
    dis = sqrt((x(1) - x(n))^2 + (y(1) - y(n)^2));
    if dis < ratio*D
        list = [list n];
    end
    for i = n-1:-1:1
        dis = sqrt((x(i + 1) - x(i))^2 + (y(i + 1) - y(i))^2);
        if dis < ratio*D
            list = [list i];
        end
    end
    

    for i = list
        n = size(x, 2);
        if i == n
            xcombine = (x(1) + x(n))/2;
            ycombine = (y(1) + y(n))/2;
            x(1) = xcombine;
            y(1) = ycombine;
            x = x(1:end - 1);
            y = y(1:end - 1);
        else
            xcombine = (x(i + 1) + x(i))/2;
            ycombine = (y(i + 1) + y(i))/2;
            x = [x(1:i - 1) xcombine x(i + 2:end)];
            y = [y(1:i - 1) ycombine y(i + 2:end)];
        end
    end
end