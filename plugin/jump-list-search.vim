fun! JLSCurrent(parsed) 
    let i = 0
    while l:i < len(a:parsed)
        if a:parsed[l:i][0] == ">" 
            return l:i
        endif

        let i = l:i + 1
    endwhile
    return -1
endfun

fun! JumpListSearch_RemoveDuplicates(buffers, pos)
    let bUp = []
    let i = a:pos

    while l:i < len(a:buffers)
        if index(l:bUp, a:buffers[l:i]) == -1
            let bUp = l:bUp + [a:buffers[l:i]]
        endif

        let i = l:i + 1
    endwhile

    let bDown = []
    let i = a:pos - 1
    while l:i >= 0
        if index(l:bDown, a:buffers[l:i]) == -1
            let bDown = [a:buffers[l:i]] + l:bDown
        endif

        let i = l:i - 1
    endwhile

    return [len(l:bDown), l:bDown + l:bUp]
endfun

fun! JumpListSearch() 
    let jumps = execute("jumps")
    let lines = split(l:jumps, '\n')
    let parsed = map(copy(l:lines), { key, val -> filter(split(val, ' '), { k, v -> len(v) })})[1:]
    let buffers = map(map(copy(l:parsed), { key, val -> 
                \     bufnr(val[len(val) - 1]) 
                \ }), { key, val -> 
                \     val == -1 ? bufnr() : val 
                \ })
    let position = JLSCurrent(l:parsed)
    return JumpListSearch_RemoveDuplicates(buffers, position)
endfun

fun! JumpListSearch_Backward()
    call JumpListSearch_Search(-1)
endfun

fun! JumpListSearch_Forward()
    call JumpListSearch_Search(1)
endfun

fun! JumpListSearch_Search(dir)
    let results = JumpListSearch()
    let pos = l:results[0]
    let buffers = l:results[1]

    echo "Buffers: " . join(buffers, ", ") . " Position: " . pos

    let current = bufnr()
    let changed = 0
    while l:pos < len(l:buffers) && l:changed == 0
        if l:buffers[l:pos] != l:current
            call nvim_set_current_buf(l:buffers[l:pos])
            let changed = 1
        end

        let pos = l:pos + a:dir
    endwhile

    if l:changed == 0
        echo "Sorry, couldn't move forward"
    endif
endfun


