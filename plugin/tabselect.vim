if exists('g:loaded_tabselect')
  finish
endif
let g:loaded_tabselect = 1

command! TabSelect call tabselect#show_tabs()

nnoremap <Plug>(tab-select) :<C-u>call tabselect#show_tabs()<CR>
nmap <silent> <C-t> <Plug>(tab-select)
