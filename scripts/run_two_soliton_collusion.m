% Run two-soliton collision demo

% addpath?

p = nls_default_params();
p.ic   = "two_soliton";
p.tmax = 5;

out = nls_solver_ifrk4(p);

nls_plot_solution(out);
nls_plot_mass_error(out);
