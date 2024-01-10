# include the code that solves the toy models
include("../src/Cauchy_1d.jl")
using Parameters
using Random

@with_kw struct model_noise <: IBVP
    noise_amp :: Float64 # the initial data is random noise; this is the amplitude
    WH :: Float64
end

"""
The following functions return a real number, it is made into a grid
function in Cauchy_1d.jl via loops
 """
# initial data
ϕ_ID(x::T, ibvp::model_noise) where {T<:Real} = ibvp.noise_amp * randn(T)
ψ_ID(x::T, ibvp::model_noise) where {T<:Real} = ibvp.noise_amp * randn(T)

# directories
toy_model = "WH_noise"
root_dir="./runs_center/"

# resolution
# change D for number of points
D = 5
Nx = (16)*2^D
noise_amplitude_drop = 0.25

# parameters to be passed in the model
p = Param(
    Nx = Nx,
    tmax = 4.0, # total time of the simulation in code units
    #CFL
    cfl = 0.25,
    # out directory
    out_dir = joinpath(root_dir, toy_model, "data_$(Nx)"),
    out_every = 1*2^D,
)

ibvp = model_noise(
    noise_amp = noise_amplitude_drop^D,
    WH = 1.0 #  for 1.0 the system is weakly hyperbolic
)

run_cauchy_1d(p, ibvp)
