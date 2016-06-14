nnoremap M :set opfunc=MoveUpDownToTargetLine<CR>:let w:invokationLine = line(".")<CR>g@
vnoremap M :<C-u>set opfunc=MoveUpDownToTargetVisual<CR>:let w:invokationLine = line(".")<CR>g@
