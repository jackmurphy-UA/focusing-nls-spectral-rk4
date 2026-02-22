function k = nls_wavenumbers(L, N)
%NLS_WAVENUMBERS FFT-consistent wavenumbers for periodic domain length L.

    k = (2*pi/L) * [0:(N/2-1), -N/2:-1].';
end