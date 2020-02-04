function [dis, x_i, constrain_i] = maxmindistance(x, y, constrain_x, constrain_y)
    B = [x' y'];
    A = [constrain_x' constrain_y'];
    C = pdist2(A, B);

    [k, I] = min(C, [], 2);
    [dis, constrain_i] = max(k);

    x_i = I(constrain_i);
end

