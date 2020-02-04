function [x, y] = line_break(x, y, ratio, D)
    n = size(x, 2);
    list = [];
    dis = sqrt((x(1) - x(n))^2 + (y(1) - y(n))^2);
    if dis > ratio*D
        list = [list n];
    end
    
    for i = n-1:-1:1
        dis = sqrt((x(i + 1) - x(i))^2 + (y(i + 1) - y(i))^2);
        if dis > ratio*D
            list = [list i];
        end
    end
    
    for i = list
        n = size(x, 2);
        if i == n
            xinsert = (x(1) + x(n))/2;
            yinsert = (y(1) + y(n))/2;
            x = [x(1:i) xinsert];
            y = [y(1:i) yinsert];
        else
            xinsert = (x(i + 1) + x(i))/2;
            yinsert = (y(i + 1) + y(i))/2;
            x = [x(1:i) xinsert x(i + 1:end)];
            y = [y(1:i) yinsert y(i + 1:end)];
        end
    end
end

