function [xnearest, ynearest] = nearest_point(x, y, edge_x, edge_y)
    a = zeros(1, 2);
    b = zeros(1, 2);
    a(1) = x - edge_x(1);
    a(2) = y - edge_y(1);
    b(1) = edge_x(2) - edge_x(1);
    b(2) = edge_y(2) - edge_y(1);
    cos_theta = a*b'/sqrt(a(1)^2 + a(2)^2)/sqrt(b(1)^2 + b(2)^2);
    projection = sqrt(a(1)^2 + a(2)^2)*cos_theta;

    if projection <= 0
        xnearest = edge_x(1);
        ynearest = edge_y(1);
    elseif projection >= sqrt(b(1)^2 + b(2)^2)
        xnearest = edge_x(2);
        ynearest = edge_y(2);
    else
        c = [edge_x(1) edge_y(1)] + projection*b/sqrt(b(1)^2 + b(2)^2);
        xnearest = c(1);
        ynearest = c(2);
    end
end

