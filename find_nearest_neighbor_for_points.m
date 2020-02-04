function [nearest_point, dis] = find_nearest_neighbor_for_points(point_x, point_y, constrain_x, constrain_y)
    constrain_n = size(constrain_x, 2);
    dis = inf;
    nearest_point = 0;
    for i = 1:constrain_n
        d = sqrt((constrain_x(i) - point_x)^2 + (constrain_y(i) - point_y)^2);
        if d < dis
            dis = d;
            nearest_point = i;
        end
    end
end

