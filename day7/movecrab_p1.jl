using DelimitedFiles
crabdata = readdlm("crabpos.txt",',',Int)
#@show crabdata

function fuelguage(crabdata)
    crabmax = maximum(crabdata)
    crabfuel = zeros(Int,1,crabmax)
    for crabfuelx in 1:crabmax
        for crabx in crabdata
            crabfuel[crabfuelx] += abs((crabfuelx-1) - crabx)
        end
    end

    #@show crabfuel
    crabfuel
end

@show minimum(fuelguage(crabdata))

