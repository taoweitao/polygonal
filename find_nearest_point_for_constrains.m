function [nearest_point] = find_nearest_point_for_constrains(x, y, point_x, point_y)
    n = size(x, 2);
    dis = inf;
    nearest_point = 0;
    for i = 1:n
        d = sqrt((x(i) - point_x)^2 + (y(i) - point_y)^2);
        if d < dis
            dis = d;
            nearest_point = i;
        end
    end
end

