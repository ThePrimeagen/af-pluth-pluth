fun! ManageAMark_Leave()
endfun

fun! ManageAMark_Enter()
endfun

augroup THE_PRIMEAGEN_MANAGE_A_MARK
    autocmd!
    autocmd BufLeave * :call ManageAMark_Leave()
    autocmd BufEnter * :call ManageAMark_Enter()
augroup END

