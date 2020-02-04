x = 0.3*sin(2*pi/50*(1:50));
y = 1 + 0.3*cos(2*pi/50*(1:50));

constrain_x = [-2+0.08*(1:49) 2*ones(1, 49) 2-0.08*(1:49) -2*ones(1, 49)];
constrain_y = [3*ones(1, 49) 3-0.08*(1:49) -1*ones(1, 49) -1+0.08*(1:49)];

[animation_x1, animation_y1] = morph(x, y, constrain_x, constrain_y, 0.7, 0.03);

constrain_x = [-1*ones(1, 50) (-1:0.1:0) sin(2*pi/100*(0:25)) sin(2*pi/100*(24:-1:0)) zeros(1, 25) (0:-0.1:-1) 0.2*sin(2*pi/50*(1:50))];
constrain_y = [(-2:0.08:2) 2*ones(1, 10) 1+cos(2*pi/100*(0:50)) (0:-0.08:-2) -2*ones(1, 10) 1.1 + 0.2*cos(2*pi/50*(1:50))];

[animation_x2, animation_y2] = morph(x, y, constrain_x, constrain_y, 0.3, 0.05);

animation_x = py.list;
animation_x1.reverse;
for i = 1:animation_x1.length
    animation_x.append(animation_x1{i});
end
for i = 1:animation_x2.length
    animation_x.append(animation_x2{i})
end

animation_y = py.list;
animation_y1.reverse;
for i = 1:animation_y1.length
    animation_y.append(animation_y1{i});
end
for i = 1:animation_y2.length
    animation_y.append(animation_y2{i})
end

% 652
% 455
old_n = 0;
cnt = 0;
for i = 1:animation_x.length
    s = animation_x{i}.tolist;
    n = s.length;
    if n == old_n
        continue;
    else
        old_n = n;
        cnt = cnt + 1;
    end
    
    x = [];
    for j = 1:s.length
        x = [x s{j}];
    end
    
    t = animation_y{i}.tolist;
    y = [];
    for j = 1:t.length
        y = [y t{j}];
    end
    
    plot_frame(x, y, [-2 -2 2 2], [-2 3 3 -2]);
    pause(0.05);
end