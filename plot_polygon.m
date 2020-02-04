function [] = plot_polygon(x, y)
    plot(x, y, 'b', x, y, 'b');
    hold on
    z_x = [x(end) x(1)];
    z_y = [y(end) y(1)];
    plot(z_x, z_y, 'b', z_x, z_y, 'b');

%     G = Generate_Graph(x, y);
%     [~, pred] = minspantree(G);
%     
%     n = size(pred, 2);
%     for i = 2:n
%         plot([x(pred(i)), x(i)], [y(pred(i)), y(i)], 'b');
%         hold on
%     end
end

