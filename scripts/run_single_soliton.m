% scripts/run_single_soliton.m
% Single-soliton evolution for focusing cubic NLS

addpath(genpath(fullfile(fileparts(mfilename('fullpath')), '..', 'src')));

p = nls_default_params();

% --- choose IC + parameters ---
p.ic  = "single_soliton";
p.A   = 2;        % amplitude
p.B   = 2;        % width parameter in sech(B(x-x0))
p.v   = -1.5;     % carrier wavenumber / velocity parameter in phase
p.x0  = 0;        % initial center

% --- simulation controls ---
p.tmax    = 5;
p.dt      = 5e-4;
p.nFrames = 200;   % store ~200 frames

out = nls_solver_ifrk4(p);

% --- plots ---
nls_plot_solution(out);
nls_plot_mass_error(out);

% Optional: quick sanity plot at final time
figure;
plot(out.x, abs(out.u(end,:)).', 'LineWidth', 1.2);
xlabel('x'); ylabel('|u(x,t_{final})|');
title('Single soliton: final profile');
grid on;
