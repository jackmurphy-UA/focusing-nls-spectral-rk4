function nls_plot_mass_error(out)
%NLS_PLOT_MASS_ERROR Plot mass drift M(t)-M(0).

    figure;
    plot(out.t, out.mass - out.mass(1), 'r-');
    xlabel('t'); ylabel('M(t)-M(0)');
    title('Mass conservation diagnostic');
    grid on;
end