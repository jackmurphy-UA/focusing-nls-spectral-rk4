# Focusing Nonlinear Schrödinger Equation (NLS) — Spectral Integrating Factor + RK4 (MATLAB)

This repository implements a numerical solver for the **1D focusing cubic nonlinear Schrödinger equation**
\[
i u_t + u_{xx} + |u|^2 u = 0,
\]
using a **Fourier spectral method (FFT)** in space and an **integrating-factor formulation** stepped forward in time with **RK4**.

The solver is designed to examine **soliton dynamics** (including two-soliton collisions) and to monitor **conservation laws** numerically.

## Highlights
- Fourier spectral discretization (FFT/IFFT) on a periodic spatial grid
- Integrating factor to handle the stiff linear dispersion term exactly
- Explicit RK4 for the nonlinear term
- Example setups: single soliton, two-soliton collision
- Diagnostic: mass conservation (with optional extension to energy)

## Mathematical Background
The focusing NLS admits localized soliton solutions and possesses conserved quantities such as **mass**
\[
M(t) = \int |u(x,t)|^2\,dx
\]
and **energy**
\[
H[u] = \int |u_x|^2\,dx - \frac{1}{2}\int |u|^4\,dx.
\]
This repository includes numerical experiments and diagnostics consistent with these invariants.

## Future Directions
Verification + Convergence study: compare numerical solution to exact 1 soliton shape and phase, and quantify $L^\infty,L^2$ error, measure mass/energy drift vs dt and vs N to investigate convergence
Structure preserving integrators (Strang, Yoshida-style)
Dealiasing (2/3) and spectral diagnostics
Could also track Hamiltonain/energy and momentum
Perturbed NLS: add weak damping/forcing and see how behaviors changes


## Repository structure
```text
.
├── README.md
├── src/                # solver + helper functions
├── scripts/            # runnable experiments
└── report/             # write-up / derivations
