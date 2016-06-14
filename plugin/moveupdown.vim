function! MoveUpDownToTargetLine(type)
    let movementBeginning =  line("'[")
    let movementEnd =  line("']")

    execute "normal! " . w:invokationLine . "gg\"qdd"

    if w:invokationLine == movementBeginning
        execute "normal! " . movementEnd . "gg\"qP"
    else
        execute "normal! " . movementBeginning  . "gg\"qP"
    endif
endfunction

function! MoveUpDownToTargetVisual(type)
    let rangeBeginning = line("'<")
    let rangeEnd = line("'>")
    let movementBeginning = line("'[")
    let movementEnd = line("']")

    execute rangeBeginning . "," . rangeEnd . "d q"

    if w:invokationLine == movementBeginning
        let relativeMovement = movementEnd - w:invokationLine
    else
        let relativeMovement = movementBeginning - w:invokationLine
    endif

    let targetLine = rangeBeginning + relativeMovement
    execute "normal! " . targetLine . "gg\"qP"
endfunction

nnoremap M :set opfunc=MoveUpDownToTargetLine<CR>:let w:invokationLine = line(".")<CR>g@
vnoremap M :<C-u>set opfunc=MoveUpDownToTargetVisual<CR>:let w:invokationLine = line(".")<CR>g@
