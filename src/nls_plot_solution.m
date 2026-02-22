function nls_plot_solution(out)
%NLS_PLOT_SOLUTION Waterfall plot of |u|.

    x = out.x;
    t = out.t;
    uabs = out.uabs;
    p = out.params;

    [X, T] = meshgrid(x, t);
    figure;
    waterfall(X, T, uabs);
    colormap(parula);
    xlabel('x'); ylabel('t'); zlabel('|u(x,t)|');
    title(sprintf('Focusing cubic NLS (N=%d, dt=%.2g)', p.N, p.dt));
    axis([min(x) max(x) 0 p.tmax 0 max(uabs(:))]);
    view(-30, 35); grid on;
end