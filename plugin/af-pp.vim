let afpp_last_three = []
let afpp_skip = 0

fun! AfPPOnEnter() 
    if g:afpp_skip
        let g:afpp_skip = 0
        return
    endif

    let id = nvim_get_current_buf()

    if bufname(id) == ""
        return
    endif

    let idx = index(g:afpp_last_three, l:id)

    if l:idx == -1 
        let g:afpp_last_three = [l:id] + g:afpp_last_three
    elseif l:idx != 0
        let length = len(g:afpp_last_three)
        let below = g:afpp_last_three[0:l:idx - 1]
        let above = g:afpp_last_three[l:idx + 1:l:length]
        let g:afpp_last_three = [l:id] + l:below + l:above
    endif

    if len(g:afpp_last_three) > 3
        let g:afpp_last_three = g:afpp_last_three[0:2]
    endif

    echom g:afpp_last_three
endfun

fun! AfPPAlternate()
    if len(g:afpp_last_three) != 3
        return
    endif

    let a = g:afpp_last_three[0]
    let b = g:afpp_last_three[1]
    let c = g:afpp_last_three[2]

    let g:afpp_skip = 1
    let g:afpp_last_three = [l:b, l:a, l:c]
    call nvim_set_current_buf(l:b)
endfun

fun! AfPPAlternatePluthPluth()
    if len(g:afpp_last_three) != 3
        return
    endif

    let a = g:afpp_last_three[0]
    let b = g:afpp_last_three[1]
    let c = g:afpp_last_three[2]

    let g:afpp_skip = 1
    let g:afpp_last_three = [l:c, l:b, l:a]
    call nvim_set_current_buf(l:c)
endfun

augroup THE_PRIMEAGEN_AF_PP
    autocmd!
    autocmd TermEnter,BufEnter,BufWinEnter,TabEnter * :call AfPPOnEnter()
augroup END
