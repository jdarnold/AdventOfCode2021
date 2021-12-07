using DelimitedFiles
ventdata = readdlm("ventdata.txt",'\n')
#@show ventdata

function parse_vents(ventdata)
    ventvector = []
    max_x = max_y = 0
    xyre = r"(\d+),(\d+) -> (\d+),(\d+)"
    for vec in ventdata
        sx1,sy1,sx2,sy2 = match(xyre,vec)
        @show sx1,sy1,sx2,sy2
        x1,y1,x2,y2 = parse(Int,sx1),parse(Int,sy1),parse(Int,sx2),parse(Int,sy2)
        push!(ventvector,[x1,y1,x2,y2])
        if x1 > max_x
            max_x = x1
        end
        if x2 > max_x
            max_x = x2
        end
        if y1 > max_y
            max_y = y1
        end
        if y2 > max_y
            max_y = y2
        end
        
    end
    ventvector,max_x, max_y
end

function populatemap(ventvect,vmap)
    maxcross = 0
    for vv in ventvect
        x1,y1,x2,y2 = vv
        
        dx = abs(x1-x2)
        dy = abs(y1-y2)
        #@show dx,dy

        if dx == 0
            if y1 > y2
                # Swap them
                y1,y2 = y2,y1
            end
            
            # mark the map
            for ypos in y1:y2
                val = vmap[ypos+1,x1+1] += 1
            end
        elseif dy == 0
            if x1 > x2
                # Swap them
                x1,x2 = x2,x1
            end
            
            # mark the map
            for xpos in x1:x2
                val = vmap[y1+1,xpos+1] += 1
            end
        end
    end

    vmap
end

ventvect, mx, my = parse_vents(ventdata)
println("Size of map: $(my+1) x $(mx+1)")
vmap = zeros(Int,my+1,mx+1)
vmap = populatemap(ventvect,vmap)

#@show vmap
@show count(>=(2),vmap)
