function draw_partial_rob()
    load('AT3.mat');
    X = 1:numel(falsif_pb.obj_log);

    set(gca, 'FontSize', 20)
    scatter(X, con1_list, 10, 'filled')
    hold on;
    scatter(X, con2_list, 10, 'filled', 'd')
    h = legend('$\mathit{rob_{speed}}$', '$\mathit{rob_{rpm}}$', 'FontSize', 40);
    set(h,'Interpreter','latex')
    xlabel('simulations', 'FontSize', 35)
    ylabel('robustness value', 'FontSize', 35)
    %axis([0 300 0 50])
    
end