if exists('g:loaded_tabselect')
  finish
endif
let g:loaded_tabselect = 1

command! TabSelect call tabselect#show_tabs()

noremap <Plug>(tabselect) :<C-t>call tabselect#show_tabs()
