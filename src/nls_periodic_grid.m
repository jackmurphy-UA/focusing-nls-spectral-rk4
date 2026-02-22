function [x, dx] = nls_periodic_grid(L, N)
%NLS_PERIODIC_GRID Periodic grid on [-L/2, L/2).

    dx = L / N;
    x  = (-L/2) + dx*(0:N-1).';
end