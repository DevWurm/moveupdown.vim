function! MoveUpDown(type)
    if line("']") == line("'x")
        exec "'x,'x move " . (line("'[") - 1)
        normal! `[
    else
        'x,'x move ']
        normal `]
    endif
    delm x
endfunction

noremap M mx:set opfunc=MoveUpDown<CR>g@
