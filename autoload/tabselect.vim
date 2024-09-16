function! tabselect#show_tabs() abort
  let tabs = gettabinfo()

  let bufnames = []
  for t in tabs
    let bufs = tabpagebuflist(t.tabnr)

    for b in bufs
      let bufnames = insert(bufnames, b . ". " . bufname(b))
    endfor
  endfor
 
  let bufnames = reverse(bufnames)
  let ctx = { 'index': 1, 'length': len(bufnames)} 
  
  call popup_menu(bufnames, {
    \ 'filter': function('s:popup_files_filter', [ctx])
    \ })
endfunction

function! s:popup_files_filter(ctx, winid, key) abort
    " 入力キーに応じた処理
    if a:key is# 'j'
        if a:ctx.index < a:ctx.length
            let a:ctx.index = a:ctx.index + 1
        endif
    elseif a:key is# 'k'
        if a:ctx.index > 0
            let a:ctx.index = a:ctx.index - 1
        endif
    elseif a:key is# "\<cr>"
        return s:open_tab(a:winid, a:ctx.index)
    elseif a:key is# "\<esc>"
        call popup_close(a:winid)
        return 1
    endif

    " それ以外は通常のpopup_filter_menuに渡す
    return popup_filter_menu(a:winid, a:key)
endfunction

function! s:open_tab(winid, index) abort
    echo a:index 
    call popup_close(a:winid)
    exe  "tabnext" a:index
    return 1
endfunction
