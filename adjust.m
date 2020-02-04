load 400hexagonsecond

index = find_boundary_points(x, y, constrain_x, constrain_y, 0.05);
boundary = find(index ~= 0);
pair1 = [];
pair2 = [];

for i = 1:size(boundary, 2) - 1
    for j = i + 1:size(boundary, 2)
        if boundary(j) ~= boundary(i) + 1 && sqrt((x(boundary(i)) -x(boundary(j)))^2 + (y(boundary(i)) - y(boundary(j)))^2) < 0.03
            pair1 = [pair1 boundary(i)];
            pair2 = [pair2 boundary(j)];
        end
    end
end

for i = size(pair1, 2):-1:1
    x = [x(1:pair1(i)) x(pair2(i) + 1:end)];
    y = [y(1:pair1(i)) y(pair2(i) + 1:end)];
end
plot_frame(x, y, constrain_x, constrain_y);

index = find_boundary_points(x, y, constrain_x, constrain_y, 0.05);
boundary = find(index ~= 0);

pair1 = [boundary(1)];
pair2 = [boundary(1)];
for i = 2:size(boundary, 2)
    if boundary(i) == boundary(i - 1) + 1
        pair2(end) = boundary(i);
    else
        pair1 = [pair1 boundary(i)];
        pair2 = [pair2 boundary(i)];
    end
end

hold on
plot(x(pair1), y(pair1), 'g.');
plot(x(pair2), y(pair2), 'g.');
hold off

for i = size(pair2, 2) - 1:-1:1
    if sqrt((x(pair2(i)) - x(pair1(i + 1)))^2 + (y(pair2(i)) - y(pair1(i + 1)))^2) < 0.1 && pair2(i) - pair1(i) + 1 < 3 && pair2(i + 1) - pair1(i + 1) + 1 < 3
        x = [x(1:pair2(i)) x(pair1(i + 1):end)];
        y = [y(1:pair2(i)) y(pair1(i + 1):end)];
    end
end

[Fx, Fy] = Fairing(x, y, 1, pi/180);
x = x + Fx;
y = y + Fy;
plot_frame(x, y, constrain_x, constrain_y);