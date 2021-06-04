# Quan-SR

Run the main script to reproduce the numerical experiments in the paper "Quantization for spectral super-resolution" by Weilin Li and Sinan Gunturk, https://arxiv.org/abs/2103.00079

Code includes the following features
1. Implements MSQ (memoryless scalar quantization) and beta quantization for non-harmonic Fourier transforms
2. Includes recovery methods based on convex optimization and subspace estimation

Requires the following third party features
1. CVX (http://cvxr.com) or any other suitable convex solver
2. Matlab's parallel computing toolbox (although not strictly necessary, it greatly reduces the run time)
