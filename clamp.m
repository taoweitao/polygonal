function [tx] = clamp(x, threshold)
    if x > threshold
        tx = threshold;
    elseif x < -threshold
        tx = -threshold;
    else
        tx = x;
    end
end

