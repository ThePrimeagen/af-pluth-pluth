let last_three = []
fun! ManageAFileOnEnter() 
    let id = nvim_get_current_buf()
    let idx = index(g:last_three, l:id)

    if l:idx == -1 
        let g:last_three = [l:id] + g:last_three
    else
        if l:idx == 0
            let g:last_three = [l:id] + g:last_three[1:2]
        elseif l:idx == 2
            let g:last_three = [l:id] + g:last_three[0:1] 
        else
            let g:last_three = [l:id] + g:last_three[0:0] + g:last_three[2:2]
        endif

        if len(g:last_three) > 3
            let g:last_three = g:last_three[0:2]
        endif
    endif
endfun

fun! ManageAFileAlteratePluthPluth()
    if len(g:last_three) != 3
        return
    endif

    let a = bufnr(bufname("%"))
    let b = bufnr(bufname("#"))
    let c = ""

    for item in g:last_three
        if l:a != l:item && l:b != l:item
            let c = l:item
            break
        endif
    endfor

    if c != ""
        call nvim_set_current_buf(l:c)
    endif
endfun

augroup THE_PRIMEAGEN_MANAGE_A_FILE
    autocmd!
    autocmd TermEnter,BufEnter,BufWinEnter,TabEnter * :call ManageAFileOnEnter()
augroup END
