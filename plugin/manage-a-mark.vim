fun! ManageAMark_GoTo(id)
    lua require('plenary.reload').reload_module("af-pluth-pluth.manage-a-mark")
    call luaeval("require('af-pluth-pluth.manage-a-mark').nav_file(_A[1])", [a:id])
endfun

fun! ManageAMark_MarkBuffer()
    lua require('plenary.reload').reload_module("af-pluth-pluth.manage-a-mark")

    call luaeval("require('af-pluth-pluth.manage-a-mark').add_file(_A[1])", [bufnr()])
endfun

fun! ManageAMark_ViewMarks()
    lua require('plenary.reload').reload_module("af-pluth-pluth.manage-a-mark")
    call luaeval("require('af-pluth-pluth.manage-a-mark').open_quick_menu()", [])
endfun

fun! ManageAMark_Save()
    lua require('plenary.reload').reload_module("af-pluth-pluth.manage-a-mark")
    call luaeval("require('af-pluth-pluth.manage-a-mark').save()", [])
endfun

fun! ManageAMark_Rm(id_like)
    lua require('plenary.reload').reload_module("af-pluth-pluth.manage-a-mark")
    call luaeval("require('af-pluth-pluth.manage-a-mark').rm_file(_A[1])", [a:id_like])
endfun

augroup THE_PRIMEAGEN_MANAGE_A_MARK
    autocmd!
    autocmd VimLeave * :call ManageAMark_Save()
augroup END
