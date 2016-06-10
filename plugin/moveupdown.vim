function! MoveUpDownLine(type)
    let sourceStart = line("'x")
    let sourceEnd = line("'x")
    call MoveUpDown(sourceStart, sourceEnd)
endfunction

function! MoveUpDownVisual(type)
    echom line("'[")
    echom line("']")
    echom line("'<")
    echom line("'>")
    let sourceStart = line("'<")
    let sourceEnd = line("'>")
    call MoveUpDown(sourceStart, sourceEnd)
endfunction

function! MoveUpDown(sourceStart, sourceEnd)
    " determine the move direction of the motion by checking if the end of motion range is the current line (-> upwards) or not (-> downwards)
    if line("']") == line("'x")
        let motionTarget = line("'[") - 1
    else
        let motionTarget = line("']")
    endif

    " determine the final destination by adding up the relative movement of the motion to the start of the source
    let destination = a:sourceStart + (motionTarget - line("'x"))

    " perform movement
    execute a:sourceStart . "," . a:sourceEnd . " move " . destination
    " move cursor to result of movement
    execute "normal! " . (destination + 1) . "gg" 
    delm x " remove 'current line mark'
endfunction

nnoremap M mx:set opfunc=MoveUpDownLine<CR>g@
vnoremap M :<C-u>set opfunc=MoveUpDownVisual<CR>mxg@
