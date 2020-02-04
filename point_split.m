function [x, y] = point_split(x, y, i)
    n = size(x, 2);

    xinsert = x(i);
    yinsert = y(i);
    x = [x(1:i) xinsert x(i + 1:end)];
    y = [y(1:i) yinsert y(i + 1:end)];
end

