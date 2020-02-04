% function [animation_x, animation_y] = morph(x, y, constrain_x, constrain_y, threshold, ratio)
    threshold = 0.5;
    ratio = 0.03;
%     constrain_x = 3*sin(2*pi/150*(1:150));
%     constrain_y = 3*cos(2*pi/150*(1:150));
%     constrain_x = [-2+0.08*(1:50) 2*ones(1, 50) 2-0.08*(1:50) -2*ones(1, 50)];
%     constrain_y = [2*ones(1, 50) 2-0.08*(1:50) -2*ones(1, 50) -2+0.08*(1:50)];

    constrain_x = [(-2:0.04:-1) (-2:0.04:-1) (2:-0.04:1) (2:-0.04:1) (-1:0.08:1) (-1:0.08:1)];
    constrain_y = [0.04*sqrt(3)*(0:25) -0.04*sqrt(3)*(0:25) 0.04*sqrt(3)*(0:25) -0.04*sqrt(3)*(0:25) sqrt(3)*ones(1, 26) -sqrt(3)*ones(1, 26)];
    x = 0.3*sin(2*pi/50*(1:50));
    y = 0.3*cos(2*pi/50*(1:50));
%     constrain_x = [-1*ones(1, 100) (-1:0.04:0) sin(2*pi/100*(0:50)) sin(2*pi/100*(49:-1:0)) zeros(1, 50) (0:-0.04:-1) 0.2*sin(2*pi/50*(1:50))];
%     constrain_y = [(-2:0.04:2) 2*ones(1, 25) 1+cos(2*pi/100*(0:100)) (0:-0.04:-2) -2*ones(1, 25) 1.1 + 0.2*cos(2*pi/50*(1:50))] - 1;
%     constrain_x = [-1*ones(1, 100) (-1:0.04:0) sin(2*pi/100*(0:50)) sin(2*pi/100*(49:-1:0)) zeros(1, 50) (0:-0.04:-1)]/0.888;
%     constrain_y = ([(-2:0.04:2) 2*ones(1, 25) 1+cos(2*pi/100*(0:100)) (0:-0.04:-2) -2*ones(1, 25)] - 1)/0.888;

    animation_x = py.list;
    animation_y = py.list;

    plot_frame(x, y, constrain_x, constrain_y)
    D = sqrt((x(1) - x(2))^2 + (y(1) - y(2))^2);
    avgforce = inf;
    
    while 1
        force = 0;
        for i = 1:400
            n = size(x, 2);
            [Bx, By] = Brownian(n, 0, 0.1*D);
            [Fx, Fy] = Fairing(x, y, 0.02, pi/4);
            [ARx, ARy] = AttractRepulse(x, y, constrain_x, constrain_y, 3*D, 1);
            [CAx, CAy] = ConstrainAttraction(x, y, constrain_x, constrain_y, threshold, ratio);
    
            [flag, s, t] = self_intersect(x + Bx + Fx + ARx + CAx, y + By + Fy + ARy + CAy);
            if flag
                temp_x = x(s + 1);
                temp_y = y(s + 1);
                x(s + 1) = x(t);
                y(s + 1) = y(t);
                x(t) = temp_x;
                y(t) = temp_y;
            end
            
            force = force + sqrt(sum((Bx + Fx + ARx + CAx).^2 + (By + Fy + ARy + CAy).^2))/size(Bx, 2);

            x = x + Bx + Fx + ARx + CAx;
            y = y + By + Fy + ARy + CAy;    
            [x, y] = line_break(x, y, 5, D);
            [x, y] = point_combine(x, y, 0.5, D);
            pause(0.001);
        
            animation_x.append(x);
            animation_y.append(y);
        
            plot_frame(x, y, constrain_x, constrain_y);
        end

        if force < avgforce
            avgforce = force
        else
            break;
        end
    end
    
% end