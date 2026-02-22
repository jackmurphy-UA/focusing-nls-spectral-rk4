function out = nls_solver_ifrk4(p)
%NLS_SOLVER_IFRK4  Focusing cubic NLS via FFT + integrating factor RK4.
%
%   i u_t + u_xx + |u|^2 u = 0  on [-L/2, L/2) with periodic BC.
%
%   Input:
%     p struct with fields:
%       L, N, dt, tmax, nFrames, ic (string), plus IC parameters
%
%   Output:
%     out struct: x, t, u (complex), uabs, mass, params

    arguments
        p struct
    end

    % --- Grid ---
    [x, dx] = nls_periodic_grid(p.L, p.N);
    k  = nls_wavenumbers(p.L, p.N);
    k2 = k.^2;

    E  = exp(1i * k2 * p.dt);
    E2 = exp(1i * k2 * (p.dt/2));

    % --- IC ---
    u0   = nls_initial_condition(x, p);
    vhat = fft(u0);

    % --- Time stepping ---
    nMax   = round(p.tmax / p.dt);
    nPlot  = max(1, floor(nMax / p.nFrames));
    nStore = floor(nMax / nPlot) + 1;

    tdata = zeros(nStore, 1);
    udata = zeros(nStore, p.N);        % complex storage
    uabs  = zeros(nStore, p.N);
    mass  = zeros(nStore, 1);

    % store initial
    storeIdx = 1;
    t = 0;
    u = u0;

    tdata(storeIdx) = t;
    udata(storeIdx,:) = u.';
    uabs(storeIdx,:)  = abs(u).';
    mass(storeIdx)    = dx * sum(abs(u).^2);

    h = waitbar(0, 'Integrating NLS...');

    for n = 1:nMax
        % IF-RK4 stages
        K1 = nls_nonlinear_increment(vhat, p.dt);
        K2 = nls_nonlinear_increment(E2 .* (vhat + 0.5*K1), p.dt);
        K3 = nls_nonlinear_increment(E2 .* (vhat + 0.5*K2), p.dt);
        K4 = nls_nonlinear_increment(E  .* (vhat + K3),     p.dt);

        vhat = E .* vhat + (E .* K1 + 2*E2 .* (K2 + K3) + K4) / 6;

        if mod(n, nPlot) == 0
            t = n * p.dt;
            u = ifft(vhat);

            storeIdx = storeIdx + 1;
            tdata(storeIdx) = t;
            udata(storeIdx,:) = u.';
            uabs(storeIdx,:)  = abs(u).';
            mass(storeIdx)    = dx * sum(abs(u).^2);

            waitbar(n/nMax, h);
        end
    end

    close(h);

    % Trim
    tdata = tdata(1:storeIdx);
    udata = udata(1:storeIdx,:);
    uabs  = uabs(1:storeIdx,:);
    mass  = mass(1:storeIdx);

    out = struct('x', x, 't', tdata, 'u', udata, 'uabs', uabs, ...
                 'mass', mass, 'params', p);
end

function K = nls_nonlinear_increment(vhat, dt)
    u = ifft(vhat);
    K = -1i * dt * fft((abs(u).^2) .* u);
end
