function [dis, x_i, constrain_i] = minmindistance(x, y, constrain_x, constrain_y, threshold)
    B = [x' y'];
    A = [constrain_x' constrain_y'];
    C = pdist2(A, B);

    [k, I] = min(C, [], 2);
    if max(k) < threshold
        dis = 0;
        return;
    end
    
    dis = 1e8;
    for i = 1:size(k, 1)
        if threshold < k(i) && k(i) < dis
            dis = k(i);
            constrain_i = i;
        end
    end
    
    x_i = I(constrain_i);
end

