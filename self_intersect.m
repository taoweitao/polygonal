function [flag, s, t] = self_intersect(x, y)
    n = size(x, 2);
    for i = 1:n
        for j = 1:n
            if j == i || mod(j - 1, n) == mod(i, n) || mod(j + 1, n) == mod(i, n)
                continue;
            end
            
            if i == n
                flag = edge_intersect([x(n) x(1)], [y(n) y(1)], [x(j) x(j + 1)], [y(j) y(j + 1)]);
            elseif j == n
                flag = edge_intersect([x(i) x(i + 1)], [y(i) y(i + 1)], [x(n) x(1)], [y(n) y(1)]);
            else
                flag = edge_intersect([x(i) x(i + 1)], [y(i) y(i + 1)], [x(j) x(j + 1)], [y(j) y(j + 1)]);
            end
            
            if flag == 1
                s = i;
                t = j;
                return;
            end
        end
    end
    flag = 0;
    s = i;
    t = j;
end