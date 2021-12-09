using DelimitedFiles
segdata = readdlm("segments.txt",' ')
#@show segdata

function initdisplay()
    
    display = Vector(undef,10)
    
    display[1] =  "abcefg"
    display[2] =  "cf"
    display[3] =  "acdeg"
    display[4] =  "acdfg"
    display[5] =  "bcdf"
    display[6] =  "abdfg"
    display[7] =  "abdefg"
    display[8] =  "acf"
    display[9] =  "abcdefg"
    display[10] = "abcdfg"
    #@show display

    displaylen = zeros(Int,1,10)
    for d in eachindex(display)
        displaylen[d] = length(display[d])
    end

    display,displaylen
end

display,displaylen = initdisplay()

@show displaylen


function findeasydigits(segdata)
    uniqseg = 0
    for segment in 1:size(segdata,1)
        #@show segment,segdata[segment,:]
        foundoutput = false
        for sigdata in segdata[segment,:]
            if foundoutput
                #okay, see if it is a unique display
                siglen = length(sigdata)
                #@show sigdata,siglen
                segmatch = count(==(siglen),displaylen)
                if segmatch == 1
                    uniqseg += 1
                end
            elseif sigdata == "|"
                foundoutput = true
            end
        end
    end
    uniqseg
end

@show findeasydigits(segdata)