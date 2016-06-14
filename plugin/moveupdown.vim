nnoremap M :set opfunc=moveupdown#MoveLine<CR>:let w:invokationLine = line(".")<CR>g@
vnoremap M :<C-u>set opfunc=moveupdown#MoveVisual<CR>:let w:invokationLine = line(".")<CR>g@
