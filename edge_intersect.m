function [flag] = edge_intersect(edge1_x, edge1_y, edge2_x, edge2_y)
    a1 = edge1_y(2) - edge1_y(1);
    b1 = edge1_x(1) - edge1_x(2);
    c1 = edge1_x(2)*edge1_y(1) - edge1_x(1)*edge1_y(2);
    
    a2 = edge2_y(2) - edge2_y(1);
    b2 = edge2_x(1) - edge2_x(2);
    c2 = edge2_x(2)*edge2_y(1) - edge2_x(1)*edge2_y(2);
    
    D = a1*b2 - a2*b1;
    if abs(D) < 1e-8
        flag = false;
        return;
    end
    
    x = (b1*c2 - b2*c1)/D;
%     y = (a2*c1 - a1*c2)/D;
    if (min(edge1_x) < x) && (x < max(edge1_x)) && (min(edge2_x) < x) && (x < max(edge2_x))
        flag = true;
        return;
    else
        flag = false;
        return;
    end
end