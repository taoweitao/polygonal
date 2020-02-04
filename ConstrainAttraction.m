function [CAx, CAy] = ConstrainAttraction(x, y, constrain_x, constrain_y, threshold, ratio)
    n = size(x, 2);
    CAx = zeros(1, n);
    CAy = zeros(1, n);
    [dis, x_i, constrain_i] = maxmindistance(x, y, constrain_x, constrain_y);
    
    if dis < threshold
        return;
    end

    CAx(x_i) = CAx(x_i) + ratio*(constrain_x(constrain_i) - x(x_i));
    CAy(x_i) = CAy(x_i) + ratio*(constrain_y(constrain_i) - y(x_i));
end

