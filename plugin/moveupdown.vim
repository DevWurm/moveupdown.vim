function! MoveUpDownToTargetLine(type)
    let rangeBeginning = w:invokationLine
    let rangeEnd = w:invokationLine
    let motionBeginning =  line("'[")
    let motionEnd =  line("']")

    " test if the motion was upwards (end of motion range is in the invokation
    " line) or not and set the corresponding target line
    if w:invokationLine == motionBeginning
        let targetLine = motionEnd
    else
        let targetLine = motionBeginning
    endif

    " execute the movement
    call MoveUpDownRange(rangeBeginning, rangeEnd, targetLine)

    " unlet the global invokationLine variable after the movement
    unlet w:invokationLine
endfunction

function! MoveUpDownToTargetVisual(type)
    let rangeBeginning = line("'<")
    let rangeEnd = line("'>")
    let motionBeginning = line("'[")
    let motionEnd = line("']")

    " test if the motion was upwards (end of motion range is in the invokation
    " line) or not and determine the relative movment of the provided motion
    if w:invokationLine == motionBeginning
        let relativeMovement = motionEnd - w:invokationLine
    else
        let relativeMovement = motionBeginning - w:invokationLine
    endif

    " calculate the target line of the movement by adding the relative
    " movement onto the beginning of the selected range
    let targetLine = rangeBeginning + relativeMovement

    " execute the movement
    call MoveUpDownRange(rangeBeginning, rangeEnd, targetLine)

    " restore selection
    execute "normal! " . targetLine . "gg" . visualmode() . (rangeEnd - rangeBeginning) . "j"

    " unlet the global invokationLine variable after the movement
    unlet w:invokationLine
endfunction

function! MoveUpDownRange(rangeBeginning, rangeEnd, targetLine)
    "store current content of working register into variable to restore it
    "later
    let registerContent = @q

    " delete given range
    execute a:rangeBeginning . "," . a:rangeEnd . "d q"

    " move to target line and insert content
    execute "normal! " . a:targetLine . "gg\"qP"

    " print status message
    if (a:rangeEnd - a:rangeBeginning) == 0
        echom "1 line moved"
    else
        echom (a:rangeEnd - a:rangeBeginning + 1) . " lines moved"
    endif

    " restore content of working register
    let @q = registerContent
endfunction

nnoremap M :set opfunc=MoveUpDownToTargetLine<CR>:let w:invokationLine = line(".")<CR>g@
vnoremap M :<C-u>set opfunc=MoveUpDownToTargetVisual<CR>:let w:invokationLine = line(".")<CR>g@
