
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


function L2_cmh_t(dir_c, dir_m, dir_h)
    # x grid
    xc = h5read(dir_c * "/x.h5", "x")
    xm = h5read(dir_m * "/x.h5", "x")
    xh = h5read(dir_h * "/x.h5", "x")

    # make sure that we can inject points from the medium and high resolution
    # grids in the coarse grid without interpolation
    @assert xc ≈ xm[1:2:end] ≈ xh[1:4:end]
    
    # dx of coarse resolution
    dxc = xc[2] - xc[1] 
    
    # list all available iterations (and corresponding files)
    (its_c, all_filenames_c) = list_h5_files(dir_c, prefix="data_")
    (its_m, all_filenames_m) = list_h5_files(dir_m, prefix="data_")
    (its_h, all_filenames_h) = list_h5_files(dir_h, prefix="data_")

    # we want to compare the common timesteps. we assume here that there is a
    # factor of 2 between the lowest resolution and the corresponding higher
    # resolution ones
    filenames_c = all_filenames_c[:]
    filenames_m = all_filenames_m[:]#[1:2:end]
    filenames_h = all_filenames_h[:]#[1:4:end]

    Nf = length(filenames_c)
    @assert length(filenames_m) == length(filenames_h) == Nf

    tt     = zeros(Nf)
    L2_cmt = zeros(Nf)
    L2_mht = zeros(Nf)

    for it in 1:Nf
        file_c = filenames_c[it]
        file_m = filenames_m[it]
        file_h = filenames_h[it]

        ϕc  = h5read(file_c, "ϕ")
        ψc  = h5read(file_c, "ψ")
        tc  = h5readattr(file_c, "./")["time"]

        ϕm  = h5read(file_m, "ϕ")
        ψm  = h5read(file_m, "ψ")
        tm  = h5readattr(file_m, "./")["time"]

        ϕh  = h5read(file_h, "ϕ")
        ψh  = h5read(file_h, "ψ")
        th  = h5readattr(file_h, "./")["time"]

        # make sure we're comparing the same timestep
        @assert tc ≈ tm ≈ th

        # compute the differences between resolutions (projected onto the coarsest grid)
        ϕcm  =  ϕc - ϕm[1:2:end]
        ϕmh  =  ϕm[1:2:end] - ϕh[1:4:end]
        ψcm  =  ψc - ψm[1:2:end]
        ψmh  =  ψm[1:2:end] - ψh[1:4:end]
        
        tt[it]     = tc

        # sum the outgoing and ingoing norms to get the complete one
        L2_cmt[it] = sqrt( sum(dxc*(ϕcm.*ϕcm +  ψcm.*ψcm)))
        L2_mht[it] = sqrt( sum(dxc*(ϕmh.*ϕmh +  ψmh.*ψmh)))
    end

    tt, L2_cmt, L2_mht
end


# maximum times we double resolution
Nmax = 5

# base lowest resolution
Nx = 16

# change directories appropriately
root_dir  = "/home/thanasis/repos/my_chaos/presentations/nr_lectures_nottingham_group/lec4/numerics/examples/runs_center/"
toy_model = "SH_smooth/"

# we need 3 different resolutions to build the L2 norm that is used in the self
# convergence ratio
for n in 0:1:Nmax-2

    @printf "n = %9d\n" n

    dir_c = joinpath(root_dir, toy_model, "data_$((Nx)*2^n)")
    dir_m = joinpath(root_dir, toy_model, "data_$((Nx)*2^(n+1))")
    dir_h = joinpath(root_dir, toy_model, "data_$((Nx)*2^(n+2))")

    tt, L2_cmt, L2_mht = L2_cmh_t(dir_c, dir_m, dir_h)

    data_dir2 = joinpath(root_dir, toy_model, "norms_self_2")
    mkpath(data_dir2)

    outfile  = joinpath(data_dir2, "L2_$(n)_$(n+1)_c$(n).dat")
    open(outfile, "w") do io
        println(io, "# t      |      L2")
        writedlm(io, [tt L2_cmt])
    end

    outfile  = joinpath(data_dir2, "L2_$(n+1)_$(n+2)_c$(n).dat")
    open(outfile, "w") do io
        println(io, "# t      |      L2")
        writedlm(io, [tt L2_mht])
    end
end
