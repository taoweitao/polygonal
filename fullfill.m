% function [animation_x, animation_y] = fullfill(x, y, constrain_x, constrain_y, ratio)
    load 400hexagon;
    
    index = find_boundary_points(x, y, constrain_x, constrain_y, 0.14);
    boundary = find(index ~= 0);
    hold on;
    plot(x(boundary), y(boundary), 'ro')
    
    ss = 0;
    for i = 1:size(boundary, 2)
        [~, dis] = find_nearest_neighbor_for_points(x(boundary(i)), y(boundary(i)), constrain_x, constrain_y);
        ss = ss + dis;
    end
    
    shrink = 0;
    for constant = 1:-0.001:0.5
        s = 0;
        for i = 1:size(boundary, 2)
            [~, dis] = find_nearest_neighbor_for_points(x(boundary(i)), y(boundary(i)), constant*constrain_x, constant*constrain_y);
            s = s + dis;
        end
        
        if s < ss
            ss = s;
            shrink = constant;
        end
    end
    
    constrain_x = shrink*constrain_x;
    constrain_y = shrink*constrain_y;
    ratio = 0.02;
%     constrain_x = [-1*ones(1, 50) (-1:0.1:0) sin(2*pi/100*(0:25)) sin(2*pi/100*(24:-1:0)) zeros(1, 25) (0:-0.1:-1) 0.2*sin(2*pi/50*(1:50))];
%     constrain_y = [(-2:0.08:2) 2*ones(1, 10) 1+cos(2*pi/100*(0:50)) (0:-0.08:-2) -2*ones(1, 10) 1.1 + 0.2*cos(2*pi/50*(1:50))];
%     constrain_x = [-1*ones(1, 50) (-1:0.1:0) sin(2*pi/100*(0:25)) sin(2*pi/100*(24:-1:0)) zeros(1, 25) (0:-0.1:-1)];
%     constrain_y = [(-2:0.08:2) 2*ones(1, 10) 1+cos(2*pi/100*(0:50)) (0:-0.08:-2) -2*ones(1, 10)];

    plot_frame(x, y, constrain_x, constrain_y);
    
    n = size(x, 2);
    constrain_n = size(constrain_x, 2);
    
    while 1
        for k = 1:100
            for i = 1:constrain_n
                nearest = find_nearest_point_for_constrains(x, y, constrain_x(i), constrain_y(i));
                [Fx, Fy] = Fairing(x, y, 1, pi/50);
                
                x(nearest) = x(nearest) + ratio*(constrain_x(i) - x(nearest));
                y(nearest) = y(nearest) + ratio*(constrain_y(i) - y(nearest));
                x = x + Fx;
                y = y + Fy;
%                 if nearest == 1
%                     if ((x(1) - x(n))*(x(1) - x(2)) + (y(1) - y(n))*(y(1) - y(2)))/sqrt((x(1) - x(n))^2 + (y(1) - y(n))^2)/sqrt((x(1) - x(2))^2 + (y(1) - y(2))^2) <= sqrt(2)/2
%                         x(nearest) = x(nearest) + ratio*(constrain_x(i) - x(nearest));
%                         y(nearest) = y(nearest) + ratio*(constrain_y(i) - y(nearest));
%                     end
%                 elseif nearest == n
%                     if ((x(n) - x(n - 1))*(x(n) - x(1)) + (y(n) - y(n - 1))*(y(n) - y(1)))/sqrt((x(n) - x(n - 1))^2 + (y(n) - y(n - 1))^2)/sqrt((x(n) - x(1))^2 + (y(n) - y(1))^2) <= sqrt(2)/2
%                         x(nearest) = x(nearest) + ratio*(constrain_x(i) - x(nearest));
%                         y(nearest) = y(nearest) + ratio*(constrain_y(i) - y(nearest));
%                     end
%                 else
%                     if ((x(nearest) - x(nearest - 1))*(x(nearest) - x(nearest + 1)) + (y(nearest) - y(nearest - 1))*(y(nearest) - y(nearest + 1)))/sqrt((x(nearest) - x(nearest - 1))^2 + (y(nearest) - y(nearest - 1))^2)/sqrt((x(nearest) - x(nearest + 1))^2 + (y(nearest) - y(nearest + 1))^2) <= sqrt(2)/2
%                         x(nearest) = x(nearest) + ratio*(constrain_x(i) - x(nearest));
%                         y(nearest) = y(nearest) + ratio*(constrain_y(i) - y(nearest));
%                     end
%                 end    

            end
            
%             [Fx, Fy] = Fairing(x, y, 0.02);
%             x = x + Fx;
%             y = y + Fy;
    
            [x, y] = line_break(x, y, 5, 0.0377);
            [x, y] = point_combine(x, y, 0.5, 0.0377);
 
            pause(0.05)
            plot_frame(x, y, constrain_x, constrain_y)
        end
        
        if size(x, 2) ~= n
            n = size(x, 2)
        else
            break;
        end
    end
    
    index = find_zigzagging_points(x, y, constrain_x, constrain_y, 0.05);
%     hold on;
%     plot(x(find(index ~= 0)), y(find(index ~= 0)), 'g.');
    zigzag = find(index ~= 0);
    
    for i = size(zigzag, 2):-1:1
        [x, y] = point_split(x, y, zigzag(i));
    end
    
    for i = 1:size(zigzag, 2)
        zigzag(i) = zigzag(i) + i - 1;
    end
    
%     while 1
        for i = 1:size(zigzag, 2)
            nearest = find_nearest_neighbor_for_points(x(zigzag(i)), y(zigzag(i)), constrain_x, constrain_y);
            if nearest == 1
                previous = constrain_n;
                next = 2;
            elseif nearest == constrain_n
                previous = constrain_n - 1;
                next = 1;
            else
                previous = nearest - 1;
                next = nearest + 1;
            end
            
            x(zigzag(i)) = x(zigzag(i)) + 1*(constrain_x(previous) - x(zigzag(i)));
            y(zigzag(i)) = y(zigzag(i)) + 1*(constrain_y(previous) - y(zigzag(i)));
            
            x(zigzag(i) + 1) = x(zigzag(i) + 1) + 1*(constrain_x(next) - x(zigzag(i) + 1));
            y(zigzag(i) + 1) = y(zigzag(i) + 1) + 1*(constrain_y(next) - y(zigzag(i) + 1));
            
            [flag, s, t] = self_intersect(x, y);
            if flag
                temp_x = x(s + 1);
                temp_y = y(s + 1);
                x(s + 1) = x(t);
                y(s + 1) = y(t);
                x(t) = temp_x;
                y(t) = temp_y;
            end
            
            pause(0.05)
            plot_frame(x, y, constrain_x, constrain_y)
        end
%     end

plot_polygon(x, y)
axis equal