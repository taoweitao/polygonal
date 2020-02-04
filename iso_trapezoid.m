function [xinsert, yinsert] = iso_trapezoid(x, y, i)
    n = size(x, 2);
    cx = x(i);
    cy = y(i);
    if i == n
        ax = x(n - 1);
        ay = y(n - 1);
        bx = x(1);
        by = y(1);
    elseif i == 1
        ax = x(n);
        ay = y(n);
        bx = x(2);
        by = y(2);
    else
        ax = x(i - 1);
        ay = y(i - 1);
        bx = x(i + 1);
        by = y(i + 1);
    end

    ux = bx - ax;
    uy = by - ay;
    dis = sqrt(ux^2 + uy^2);
    ux = ux/dis;
    uy = uy/dis;
    Ux = -uy;
    Uy = ux;
    vx = (ax + bx)/2 - cx;
    vy = (ay + by)/2 - cy;
    xinsert = (ax + bx)/2 + (vx*ux + vy*uy)*ux - (vx*Ux + vy*Uy)*Ux;
    yinsert = (ay + by)/2 + (vx*ux + vy*uy)*uy - (vx*Ux + vy*Uy)*Uy;
end

