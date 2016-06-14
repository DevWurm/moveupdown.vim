function! MoveUpDownToTargetLine(type)
    let target = line("'q")
    let beginning =  line("'[")
    let end =  line("']")

    execute "normal! " . target . "gg\"qdd"

    if target == beginning
        execute "normal! " . end . "gg\"qP"
    else
        execute "normal! " . beginning  . "gg\"qP"
    endif
endfunction

function! MoveUpDownToTargetVisual(type)
    let rangeBeginning = line("'<")
    let rangeEnd = line("'>")
    let target = line("'q")
    let beginning =  line("'[")
    let end =  line("']")

    execute rangeBeginning . "," . rangeEnd . "d q"

    if target == beginning
        let relativeMovement = end - target
        let targetLine = rangeBeginning + relativeMovement
        execute "normal! " . targetLine . "gg\"qP"
    else
        let relativeMovement = beginning - target
        let targetLine = rangeBeginning + relativeMovement
        execute "normal! " . targetLine . "gg\"qP"
    endif
endfunction

nnoremap M mq:set opfunc=MoveUpDownToTargetLine<CR>g@
vnoremap M :<C-u>set opfunc=MoveUpDownToTargetVisual<CR>mqg@
