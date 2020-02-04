function [index] = find_boundary_points(x, y, constrain_x, constrain_y, R)
    n = size(x, 2);
    index = zeros(1, n);
    
    for i = 1:n
        [~, dis] = find_nearest_neighbor_for_points(x(i), y(i), constrain_x, constrain_y);
        if dis < R
            index(i) = 1;
        end
    end

end

