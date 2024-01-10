The material under this directory was used during lecture 4 to
demonstrate topics related to numerical implementation.

The models solved are

∂_t ϕ = ∂_x ϕ + a*∂_x ψ,\
∂_t ψ = ∂_x ψ,

and the domain x is periodic. The discretization is performed with 2nd
order accurate finite difference operators and the time integration
with the method of lines and using a 4th order accurate Runge-Kutta
integrator. The implementation is performed using the Julia
programming language https://julialang.org/. The scripts are tested
with Julia 1.5.3 and 1.8.5.

When a=0, the system is strongly hyperbolic and when a=1 it is weakly
hyperbolic. Pointwise and norm convergence tests are presented, the
details of which can be found in Sec. IV of
https://arxiv.org/abs/2007.06419. Even though the models of the paper
and the lecture are different, the discussion regarding convergence
and hyperbolicity is the same. The construction of the tests in done
in the same way and the expected convergence rates are the same.

The analysis uses Jupyter notebooks for visualization.
