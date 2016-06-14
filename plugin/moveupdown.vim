command MoveUpDownLine :set opfunc=moveupdown#MoveLine<CR>:let w:invokationLine = line(".")<CR>g@
command MoveUpDownVisual :<C-u>set opfunc=moveupdown#MoveVisual<CR>:let w:invokationLine = line(".")<CR>g@
