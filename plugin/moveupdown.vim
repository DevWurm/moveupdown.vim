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

nnoremap M mq:set opfunc=MoveUpDownToTargetLine<CR>g@
