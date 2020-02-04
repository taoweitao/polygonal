function [] = plot_frame(x, y, constrain_x, constrain_y)
    plot(constrain_x, constrain_y, 'r.');
    hold on;
    plot_polygon(x, y);
    hold off;
    axis([min(constrain_x) max(constrain_x) min(constrain_y) max(constrain_y)]);
    axis equal;
end