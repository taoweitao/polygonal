function [index] = find_zigzagging_points(x, y, constrain_x, constrain_y, R)
    n = size(x, 2);
    index = zeros(1, n);
    
    for i = 1:n
        [~, dis] = find_nearest_neighbor_for_points(x(i), y(i), constrain_x, constrain_y);
        if dis > R
            continue;
        end
        
        if i == 1
            [~, dis1] = find_nearest_neighbor_for_points(x(n), y(n), constrain_x, constrain_y);
            [~, dis2] = find_nearest_neighbor_for_points(x(2), y(2), constrain_x, constrain_y);
            
            if dis1 >= 3*R/4 && dis2 >= 3*R/4
                index(i) = 1;
            end
        elseif i == n
            [~, dis1] = find_nearest_neighbor_for_points(x(n - 1), y(n - 1), constrain_x, constrain_y);
            [~, dis2] = find_nearest_neighbor_for_points(x(1), y(1), constrain_x, constrain_y);
            
            if dis1 >= 3*R/4 && dis2 >= 3*R/4
                index(i) = 1;
            end
        else
            [~, dis1] = find_nearest_neighbor_for_points(x(i - 1), y(i - 1), constrain_x, constrain_y);
            [~, dis2] = find_nearest_neighbor_for_points(x(i + 1), y(i + 1), constrain_x, constrain_y);
            
            if dis1 >= 3*R/4 && dis2 >= 3*R/4
                index(i) = 1;
            end
        end        
    end
end

