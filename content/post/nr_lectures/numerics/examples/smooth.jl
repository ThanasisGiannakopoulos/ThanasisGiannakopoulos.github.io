# include the code that solves the toy models
include("../src/Cauchy_1d.jl")

using Parameters
using Random

# parameter that control the hyperbolicity of the model
@with_kw struct model_smooth <: IBVP
    WH :: Float64
end

# initial data; a Gaussian
function ID_gauss(x::Real)
    f =  exp( -((x - 0.5) / 0.12)^2 )
end

"""
The following functions return a real number, it is made into a grid
function in Cauchy_1d.jl via loops
 """
# initial data
ϕ_ID(x::T, ibvp::model_smooth) where {T<:Real} = ID_gauss(x)
ψ_ID(x::T, ibvp::model_smooth) where {T<:Real} = ID_gauss(x)

# directories to save data
toy_model = "SH_smooth"
root_dir="./runs_upwind_leftmov/"

# resolution
# change D for number of points
D = 5
Nx = (16)*2^D
#noise_amplitude_drop = 0.25

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

ibvp = model_smooth(
    WH = 0.0 # for 0.0 the model is strongly hyperbolic
)

run_cauchy_1d(p, ibvp)
