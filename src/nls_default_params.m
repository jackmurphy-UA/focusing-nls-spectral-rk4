function p = nls_default_params()
%NLS_DEFAULT_PARAMS Default parameters for focusing cubic NLS demos.

    p.L      = 40;
    p.N      = 512;
    p.dt     = 5e-4;
    p.tmax   = 5;
    p.nFrames = 150;

    p.ic = "two_soliton";

    % single soliton
    p.A  = 2;  p.B = 2;  p.v = -1.5;  p.x0 = 0;

    % two solitons
    p.A1 = 2; p.B1 = 1; p.v1 = -2; p.x01 = -10;
    p.A2 = 2; p.B2 = 1; p.v2 = +2; p.x02 = +10;

    % gaussian
    p.gA = 2; p.gB = 2;
end