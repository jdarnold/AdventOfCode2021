using DelimitedFiles
fishdata = readdlm("llist.txt",',',Int)
@show fishdata

function agefish(fishdata,day)
    if day == 81
        @show length(fishdata)
        return
    end

    newfishes = 0
    for fishidx in eachindex(fishdata)
        fish = fishdata[fishidx]
        if fish == 0
            fish = 6
            newfishes += 1
        else
            fish -= 1
        end
        fishdata[fishidx] = fish
    end

    fishdata = [fishdata fill(8,1,newfishes)]
    #@show fishdata

    agefish(fishdata,day+1)
end

agefish(fishdata,1)
