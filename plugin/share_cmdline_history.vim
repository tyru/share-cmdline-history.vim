scriptencoding utf-8

if exists('g:loaded_share_cmdline_history')
  finish
endif
let g:loaded_share_cmdline_history = 1

let s:save_cpo = &cpo
set cpo&vim


function! s:define_user_map(map, mode) abort
    let oldmap = maparg(a:map, a:mode, 0, 1)
    if !empty(oldmap)
        if oldmap.noremap
            let mapcmd = a:mode . 'noremap'
        else
            let mapcmd = a:mode . 'map'
        endif
        if oldmap.silent
            let mapcmd .= '<silent>'
        endif
        if oldmap.expr
            let mapcmd .= '<expr>'
        endif
        if oldmap.buffer
            let mapcmd .= '<buffer>'
        endif
        if oldmap.nowait
            let mapcmd .= '<nowait>'
        endif
        if oldmap.sid !=# ''
            let mapcmd .= '<script>'
        endif
        let mapcmd .= printf(' <SID>(user-%s) %s', a:map, oldmap.rhs)
        execute mapcmd
    else
        execute printf(a:mode . 'noremap <SID>(user-%s) %s', a:map, a:map)
    endif
endfunction

" Assumed <SID>(user-:) supports v:count handling.
call s:define_user_map(':', 'n')
call s:define_user_map(':', 'x')
nnoremap <silent> <SID>(rviminfo) :<C-u>rviminfo<CR>
xnoremap <silent> <SID>(rviminfo) :<C-u>rviminfo<CR>
nnoremap <script><expr> : '<SID>(rviminfo)' . (v:count ==# 0 ? '' : v:count) . '<SID>(user-:)'
xnoremap <script> : <SID>(rviminfo)gv<SID>(user-:)

call s:define_user_map('<CR>', 'c')
" Assumed <SID>(user-<CR>) escaped from command-line mode.
nnoremap <silent> <SID>(wviminfo) :<C-u>wviminfo<CR>
cnoremap <script> <CR> <C-]><SID>(user-<CR>)<SID>(wviminfo)


delfunction s:define_user_map

let &cpo = s:save_cpo
unlet s:save_cpo
" vim:set et:
