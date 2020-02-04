function [G] = Generate_Graph(x, y)
    n = size(x, 2);
    s = zeros(1, n*(n - 1)/2);
    t = zeros(1, n*(n - 1)/2);
    w = zeros(1, n*(n - 1)/2);
    cnt = 0;
    for i = 1:n - 1
        for j = i + 1:n
            cnt = cnt + 1;
            s(cnt) = i;
            t(cnt) = j;
            w(cnt) = sqrt((x(j) - x(i))^2 + (y(j) - y(i))^2);
        end
    end
    
    G = graph(s, t, w);
end

