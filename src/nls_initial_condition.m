function u0 = nls_initial_condition(x, p)
%NLS_INITIAL_CONDITION Construct initial data u(x,0).

    switch p.ic
        case "single_soliton"
            u0 = p.A * sech(p.B*(x - p.x0)) .* exp(1i*p.v*(x - p.x0));

        case "two_soliton"
            u1 = p.A1 * sech(p.B1*(x - p.x01)) .* exp(1i*p.v1*(x - p.x01));
            u2 = p.A2 * sech(p.B2*(x - p.x02)) .* exp(1i*p.v2*(x - p.x02));
            u0 = u1 + u2;

        case "gaussian"
            u0 = p.gA * exp(-p.gB * x.^2);

        otherwise
            error('Unknown p.ic = %s', string(p.ic));
    end
end