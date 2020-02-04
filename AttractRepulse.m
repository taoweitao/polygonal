function [ARx, ARy] = AttractRepulse(x, y, constrain_x, constrain_y, R, nmin)
    Lennard_Jones = @(r) r^(-12) - r^(-6);
    n = size(x, 2);
    constrain_n = size(constrain_x, 2);
    ARx = zeros(1, n);
    ARy = zeros(1, n);
    for i = 1:n
        for j= 1:n
            flag = false;
            for t = j - nmin + 1:j + nmin
                if mod(t, n) == mod(i, n)
                    flag = true;
                    break;
                end
            end
            if flag == true
                continue;
            end
            
%             if j == i || (mod(j + 1, n) == mod(i, n))
%                 continue;
%             end
            
            if j ~= n
                [xnearest, ynearest] = nearest_point(x(i), y(i), [x(j) x(j + 1)], [y(j) y(j + 1)]);
            else
                [xnearest, ynearest] = nearest_point(x(i), y(i), [x(n) x(1)], [y(n) y(1)]);
            end
            dis = sqrt((xnearest - x(i))^2 + (ynearest - y(i))^2);           
            if dis < R
                kx = (x(i) - xnearest)/dis*Lennard_Jones(dis/R);
                ky = (y(i) - ynearest)/dis*Lennard_Jones(dis/R);
                kx = clamp(kx, 0.02*R);
                ky = clamp(ky, 0.02*R);
            
                ARx(i) = ARx(i) + kx;
                ARy(i) = ARy(i) + ky;
            end
        end
    end

    for i = 1:n
        for j= 1:constrain_n
            if j ~= constrain_n
                [xnearest, ynearest] = nearest_point(x(i), y(i), [constrain_x(j) constrain_x(j + 1)], [constrain_y(j) constrain_y(j + 1)]);
            else
                [xnearest, ynearest] = nearest_point(x(i), y(i), [constrain_x(constrain_n) constrain_x(1)], [constrain_y(constrain_n) constrain_y(1)]);
            end
            dis = sqrt((xnearest - x(i))^2 + (ynearest - y(i))^2);
            if dis < R
                kx = (x(i) - xnearest)/dis*Lennard_Jones(dis/R);
                ky = (y(i) - ynearest)/dis*Lennard_Jones(dis/R);
                kx = clamp(kx, 0.02*R);
                ky = clamp(ky, 0.02*R);
            
                ARx(i) = ARx(i) + kx;
                ARy(i) = ARy(i) + ky;
            end
        end
    end
    
end

