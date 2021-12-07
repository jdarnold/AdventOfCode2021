using DelimitedFiles
crabdata = readdlm("crabpos_t.txt",',',Int)
#@show crabdata

function fuel1(cx1, cx2)
    abs((cx1-1) - cx2)
end

function fuel2(cx1, cx2)
    if cx1 < cx2
        # Swap for ease of use
        cx1,cx2 = cx2,cx1
    end

    dx = cx1 - cx2
    fx = (dx+1)*(floor(dx/2))
    if dx % 2 > 0
        fx += (dx+1)/2
    end

    fx
end

function fuelguage(crabdata,fuelfunc)
    crabmax = maximum(crabdata)
    crabfuel = zeros(Int,1,crabmax)
    for crabfuelx in 1:crabmax
        for crabx in crabdata
            crabfuel[crabfuelx] += fuelfunc(crabfuelx, crabx)
        end
    end

    #@show crabfuel
    crabfuel
end

@show minimum(fuelguage(crabdata, fuel1))
@show minimum(fuelguage(crabdata, fuel2))

