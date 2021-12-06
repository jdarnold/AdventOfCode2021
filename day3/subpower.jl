using DelimitedFiles
powerdata = readdlm("powerdata.txt",' ',String)

@show powerdata

function powerconsumption(powerdata)
    gamma = 0
    epsilon = 0

    onecount = zeros(Int32,length(powerdata[1]))
                     
    for data in powerdata
        one = 0
        zero = 0

        #@show data

        for ci in eachindex(data)
            val = data[ci]
            #@show val
            if val == '1'
                onecount[ci] += 1
            end
        end

        #@show onecount
    end
    
    half = length(powerdata) / 2
    
    for one in onecount
        
        gamma <<= 1
        epsilon <<= 1
        
        if one > half
            gamma |= 1
        else
            epsilon |= 1
        end
 end

    @show gamma, epsilon, gamma*epsilon
            
end
powerconsumption(powerdata)

function count_ones(input,index)

    ones = 0
    
    for data in input
        if data[index] == '1'
            ones += 1
        end
    end

    return ones
end

function get_rating(powerdata, index, comp_func)

    @show length(powerdata), index
    
    if length(powerdata) == 1
        return powerdata[1]
    end
    
    @show one_count = count_ones(powerdata, index)

    use1 = comp_func(one_count, powerdata)
    vsize = one_count
    if !use1
        vsize = length(powerdata) - one_count
    end
    
    new_data = Vector{String}(undef,vsize)
    dx = 1
    for data in powerdata
        @show dx,index
        if use1 && data[index] == '1'
            new_data[dx] = data
            dx += 1
            
        elseif !use1 && data[index] == '0'
            new_data[dx] = data
            dx += 1
            
        end
    end

    get_rating(new_data,index+1,comp_func)
            
end

function oxygen_compare(one_count, data)
    return one_count >= (length(data)/2)
end

oxygen_s = get_rating(powerdata,1, oxygen_compare)
@show oxygen = parse(Int32,"0b"*oxygen_s)

function co2_compare(one_count, data)
    return one_count < (length(data)/2)
end

co2_s = get_rating(powerdata,1,co2_compare)
@show co2 = parse(Int32,"0b"*co2_s)

println("life support rating = $(co2*oxygen)")
