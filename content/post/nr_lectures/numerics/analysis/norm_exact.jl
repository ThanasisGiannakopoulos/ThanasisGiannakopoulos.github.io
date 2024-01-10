
using HDF5
using DelimitedFiles
using Printf

function list_h5_files(foldername::String; prefix::String="data_")
    path     = abspath(foldername)
    allfiles = readdir(path)

    Ns = length(prefix)

    its_names = Tuple[]
    # append only the files whose names start with the given prefix
    for file in allfiles
        try
            if (file[1:Ns] == prefix && file[end-2:end] == ".h5")
                # extract iteration
                it_str = file[Ns+1:end-3]
                fullname = joinpath(path, file)
                # add to list of tuples with iteration and name
                push!(its_names, (parse(Int64, it_str), fullname))
            end
        catch ex
            if isa(ex, BoundsError)
                # probably triggered by string comparison; do nothing
            else
                throw(ex)
            end
        end
    end

    # sort according to iteration
    sort!(its_names)
    # and extract the list of filenames and iterations
    filenames = [name for (it, name) in its_names]
    its       = [it for (it, name) in its_names]

    (its, filenames)
end

function L2_t_func(dir)
    # x grid
    x = h5read(dir * "/x.h5", "x")
    
    # dρ of different resolutions
    dx = x[2] - x[1] 
    
    # list all available iterations (and corresponding files)
    (its, all_filenames) = list_h5_files(dir, prefix="data_")
    
    filenames = all_filenames[:]
    
    Nf = length(filenames)
    tt    = zeros(Nf)
    L2_t = zeros(Nf)
    
    for it in 1:Nf#add a progression bar and maybe multithread
        file = filenames[it]
        
        ϕ  = h5read(file, "ϕ")
        ψ  = h5read(file, "ψ")
        t  = h5readattr(file, "./")["time"]
        
        tt[it]  = t
        
        # sum the outgoing and ingoing norms to get the complete one
        L2_t[it] = sqrt( sum(dx*(ϕ.*ϕ + ψ.*ψ)))
    end
    
    tt, L2_t
end


# maximum times we double resolution
Nmax = 5

# base lowest resolution
Nx = 16

# change directories appropriately
root_dir  = "/home/thanasis/repos/my_chaos/presentations/nr_lectures_nottingham_group/lec4/numerics/examples/runs_center/"
toy_model = "WH_noise/"

# we need 3 different resolutions to build the L2 norm that is used in the self
# convergence ratio
for n in 0:1:Nmax

    @printf "n = %9d\n" n

    dir = joinpath(root_dir, toy_model, "data_$((Nx)*2^n)")
    
    tt, L2_t = L2_t_func(dir)

    data_dir2 = joinpath(root_dir, toy_model, "norms_exact_2")
    mkpath(data_dir2)

    outfile  = joinpath(data_dir2, "L2_$(n).dat")
    open(outfile, "w") do io
        println(io, "# t      |      L2")
        writedlm(io, [tt L2_t])
    end

end
