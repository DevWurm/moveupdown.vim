function! MoveUpDown(type)
    " set source and target lines depening on visual (-> selection) / nonvisual (-> line) mode
    if a:type == "block"
        let sourceStart = line("'<")
        let sourceEnd = line("'>")
    else
        let sourceStart = line("'x")
        let sourceEnd = line("'x")
    endif

    " determine the move direction of the motion by checking if the end of motion range is the current line (-> upwards) or not (-> downwards)
    if line("']") == line("'x")
        let motionTarget = line("'[") - 1
    else
        let motionTarget = line("']")
    endif

    " determine the final destination by adding up the relative movement of the motion to the start of the source
    let destination = sourceStart + (motionTarget - line("'x"))

    " perform movement
    execute sourceStart . "," . sourceEnd . " move " . destination
    " move cursor to result of movement
    execute "normal! " . destination . "gg" 
    delm x " remove 'current line mark'
endfunction

nnoremap M mx:set opfunc=MoveUpDown<CR>g@
vnoremap M mx:<C-u>set opfunc=MoveUpDown<CR>g@
