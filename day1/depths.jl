using DelimitedFiles
depths = readdlm("depths_test.txt",Int32)

@show length(depths)

prev_depth = 1000000
depth_increases = 0

for di in eachindex(depths)
    if (di+2) > length(depths)
        break
    end
    
    d3 = depths[di] + depths[di+1] + depths[di+2]
    if d3 > prev_depth
        global depth_increases += 1
    end
    global prev_depth = d3
end

@show depth_increases

