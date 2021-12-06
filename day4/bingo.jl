using DelimitedFiles
bingodata = readdlm("bingodata.txt",',',Int32)
@show bingodata

bingoboards = readdlm("bingoboards.txt",' ',Int32,'\n')
@show bingoboards
@show typeof(bingoboards)

function get_bingo_boards(bingoboarddata)
    index = 1

    global boardcount = Int(length(bingoboarddata)/25)

    boards = Vector{Matrix{Int32}}(undef,boardcount)
    println( "# of boards: $boardcount")

    for b = 1:boardcount
        #println("Get board $b")
        boards[b] = bingoboarddata[index:index+4, :]

        #println("boards[$b] = $(boards[b])")
        index += 5
    end

    return boards
end

boards = get_bingo_boards(bingoboards)
@show boards

function draw_ball(ballnumber, boards)
    for bi in eachindex(boards)
        if boards[bi][1] == 10_000
            continue
        end

        #println("boards[$bi] = $(boards[bi])")
        for bb in eachindex(boards[bi])
            if boards[bi][bb] == ballnumber
                #println("Replacing $ballnumber")
                boards[bi][bb] = -1
            end
        end
    end
end

function check_for_bingo(boards)
    bingo = fill(-1,5)
    for bi in eachindex(boards)
        if boards[bi][1] == 10_000
            continue
        end
        
        for a in 1:5
            if boards[bi][a,:] == bingo
                #println("BINGO! $(boards[bi])")
                return bi # boards[bi]
            end
        end
        for a in 1:5
            if boards[bi][:,a] == bingo
                #println("BINGO! $(boards[bi])")
                return bi #boards[bi]
            end
        end
    end

    return nothing
end

#function find_winner(boardcount, boards)
    losers = falses(boardcount)
    winners = trues(boardcount)

    for ball in bingodata
        draw_ball(ball, boards)
        #println("ball= $ball, boards = $boards")
        while   (bx = check_for_bingo(boards)) != nothing
            println("We found it! board # $bx")
            losers[bx] = true
            #if winners == losers
                @show "found last one: $bx"
                bingo = boards[bx]
                bingo[bingo.==-1] .= 0
                global lastbingo = deepcopy(bingo)
            @show lastbingo, bx
                global lastball = ball
            #return
            #end
            boards[bx][1] = 10_000
        end
    end
#end


#@show boards[2]
@show lastbingo
println("Sum of bingo card: $(sum(lastbingo))")
println("Times ball number: $(sum(lastbingo)*lastball)")
