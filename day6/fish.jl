using DelimitedFiles
fishdata = readdlm("llist.txt",',',Int)
@show fishdata

fishages = zeros(Int,1,9)

function init_fishes(fd,fishages)
    for age in fd
        fishages[age+1] += 1
    end

    return fishages
end

function agefish(fishages)
    age0 = fishages[1]
    for fi in 2:length(fishages)
        fishages[fi-1] = fishages[fi]
    end
    fishages[7] += age0
    fishages[9] = age0
end

init_fishes(fishdata,fishages)
@show fishages

for days in 1:256
    agefish(fishages)
end

@show fishages
@show sum(fishages)
