# the code that solves the toy model

# functions that are exported and called in the examples
export Param, IBVP, run_cauchy_1d

# libraries
using Parameters
using DifferentialEquations
using HDF5
using Printf
using RecursiveArrayTools
using Random

# paramteres to be passed
@with_kw struct Param
    # discretization parameters
    Nx                :: Int
    tmax              :: Float64
    # directory to save data
    out_dir           :: String
    #CFL
    cfl               :: Float64 = 0.25
    # how often to save data
    out_every               :: Int
end

# structure that helps us change between a strongly and a weakly hyperbolic
# toy model
abstract type IBVP end

"""
Functions that define the ID of ϕ, ψv, and ψ at t=0, i.e. ψ(t=0,ρ).
Needs signature ψ1_ID(ρ::T, ibvp::IBVP) where {T<:Real}, 
and similar for ϕ and ψv.
"""
function ϕ_ID end
function ψ_ID end

struct System{T}
    x     :: Vector{T}
    hx    :: T
end
function System(p::Param)
    hx = 1 / (p.Nx) # remove last point; 0=1 (periodic)
    x  = range(0, 1-hx, length=p.Nx)
    System{typeof(hx)}(x, hx)
end

# 2nd order accurate finite difference operators
# to approximate 1st order spatial derivatives

# centered
function  Dx_center_periodic!(f_x::Vector, f::Vector, sys::System)
    Nx = length(f)
    odx2 = 0.5 / sys.hx

    @inbounds for i in 2:Nx-1
        f_x[i] = (f[i+1] - f[i-1]) * odx2
    end

    f_x[1]  = (f[2] - f[end]) * odx2
    f_x[end]   = (f[1] - f[end-1]) * odx2
    f_x
end

#upwind
function  Dx_upwind_periodic!(f_x::Vector, f::Vector, sys::System)
    Nx = length(f)
    odx2 = 0.5 / sys.hx

    @inbounds for i in 1:Nx-2
        f_x[i] = (-3.0* f[i] + 4.0*f[i+1] - f[i+2]) * odx2
    end

    f_x[end]     = (-3.0* f[end] + 4.0*f[1] - f[2]) * odx2
    f_x[end-1]   = (-3.0* f[end-1] + 4.0*f[end] - f[1]) * odx2
    f_x
end

# you can choose which in to use below
function Dx(f, sys::System)
    f_x = similar(f)
    Dx_upwind_periodic!(f_x, f, sys) # change this appropriately
end

# function for initial data for ϕ
function init_ϕ(sys::System{T}, ibvp::IBVP) where {T}
    Nx = length(sys.x)

    f0 = zeros(T, Nx)

    @inbounds for i in 1:Nx
        f0[i] = ϕ_ID(sys.x[i], ibvp)
    end
    f0
end

# function for initial data for ψ
function init_ψ(sys::System{T}, ibvp::IBVP) where {T}
    Nx = length(sys.x)

    f0 = zeros(T, Nx)

    @inbounds for i in 1:Nx
        f0[i] = ψ_ID(sys.x[i], ibvp)
    end
    f0
end

# setup the right-hand-side of the toy model
# below dv := ∂_t v, where v is the state vector
function setup_rhs!(dv, v, (sys, ibvp), t)

    dϕ  = dv[1]
    ϕ   = v[1]
    dψ  = dv[2]
    ψ   = v[2]
    
    # take ρ derivatives
    ϕ_x  = Dx(ϕ, sys)
    ψ_x  = Dx(ψ, sys)
    
    # the rhs 
    dϕ  .=   ϕ_x + ibvp.WH* ψ_x
    dψ  .=   ψ_x 
    
    dv # the function returns the time derivative dv 
end

# function to write data
function write_1D(it::Int, t, data_dir::String,
                  ϕ::Array, ψ::Array)
    it_str  = lpad(it, 4, "0")
    outfile = joinpath(data_dir, "data_$(it_str).h5")
    h5open(outfile, "w") do file
        write(file, "ϕ" ,  ϕ)
        write(file, "ψ",  ψ)
        attrs(file)["time"] = t
    end
    nothing
end

# function that performs the time evolution
function run_cauchy_1d(p::Param, ibvp::IBVP)

    # pass the parameters of the system
    sys = System(p)

    # create the folders where data are saved
    data_dir = mkpath(p.out_dir)

    # initialize ϕ, ψ
    ϕ  = init_ϕ(sys, ibvp) 
    ψ  = init_ψ(sys, ibvp)
    
    # time span of the simulation
    tspan = (0.0, p.tmax)

    # timestep. careful with CFL condition
    dt0   = p.cfl* sys.hx

    # write the ID as a vector for the coupled PDE system
    v0 = VectorOfArray([ϕ, ψ])
    
    # define the PDE problem
    prob = ODEProblem(setup_rhs!, v0, tspan, (sys, ibvp))
    # http://docs.juliadiffeq.org/latest/basics/integrator.html
    # you can change the integration method
    # below it's 4th order Runge-Kutta (RK4)
    integrator = init(prob, RK4(), save_everystep=false, dt=dt0, adaptive=false)

    # write the coordinates.
    h5write(data_dir*"/x.h5", "x", sys.x)

    it = 0
    t  = 0.0

    # save initial data
    write_1D(it, t, data_dir, ϕ, ψ)

    # print messages while the code runs
    println("-------------------------------------------------------------")
    println("Iteration      Time |           ϕ            |           ψ           |")
    println("                    |    minimum      maximum |    minimum      maximum |")
    println("-------------------------------------------------------------")
    @printf "%9d %9.3f |  %9.4g    %9.4g|  %9.4g    %9.4g\n" it t minimum(ϕ) maximum(ϕ) minimum(ψ) maximum(ψ)

    # start time evolution
    for (v,t) in tuples(integrator)
        it += 1

        ϕ  = v[1]
        ψ  = v[2]
        
        @printf "%9d %9.3f |  %9.4g    %9.4g|  %9.4g    %9.4g\n" it t minimum(ϕ) maximum(ϕ) minimum(ψ) maximum(ψ)

        if it % p.out_every == 0
            write_1D(it, t, data_dir, ϕ, ψ)
        end
    end

    println("-------------------------------------------------------------")
    println("Done.")
end
