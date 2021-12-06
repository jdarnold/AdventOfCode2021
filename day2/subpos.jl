using DelimitedFiles
movements = readdlm("subdirections_t.txt",' ')

@show movements

function movesub(movements)

    depth = 0
    position = 0
    aim = 0
    
    for move in eachindex(movements)
        if move > length(movements)/2
            break
        end
        
        direction = movements[move,1]
        distance = movements[move,2]
        @show direction, distance
        
        if direction == "forward"
            position += distance
            depth += (aim*distance)
        elseif direction == "down"
            aim += distance
        elseif direction == "up"
            aim -= distance
        end
#        @show depth,position
    end

    @show depth*position
end

movesub(movements)

