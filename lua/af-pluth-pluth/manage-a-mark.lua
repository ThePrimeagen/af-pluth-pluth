local Path = require('plenary.path')
local float = require('plenary.window.float')
local factorw = 0.42069
local factorh = 0.69420

local M = {}

win_id = nil
bufh = nil

local cwd = cwd or vim.loop.cwd()
local data_path = vim.fn.stdpath("data")

cwd = cwd:gsub("/", "_")

local file_name = string.format("%s/%s.cache", data_path, cwd)

function hydrate_from_cache() 
    --[[
    if not vim.g.manage_a_mark_cache_files then
        return {}
    end
    --]]

    ok, res = pcall(function()
        local results = Path:new(file_name):read()
        if results == nil then
            return {}
        end
        return vim.fn.json_decode(results)
    end)

    if ok then
        return res
    end

    return {}
end

M.save = function() 
    Path:new(file_name):write(vim.fn.json_encode(marked_files), 'w')
end

marked_files = marked_files or hydrate_from_cache() or {}

function create_window() 
    local win_info = float.percentage_range_window(
        factorw, 
        factorh, 
        {
            winblend = 0
        })

    return win_info
end

function get_index_of(item) 
    if type(item) == 'string' then
        for idx = 1, #marked_files do
            if marked_files[idx] == item then
                return idx
            end
        end

        return nil
    end

    if vim.g.manage_a_mark_zero_index then
        item = item + 1
    end

    if item <= #marked_files and item >= 1 then
        return item
    end

    return nil
end

M.open_quick_menu = function() 
    if win_id == nil then
        local win_info = create_window()
        win_id = win_info.win_id
        bufh = win_info.bufh
    end

    local contents = {}
    for idx = 1, #marked_files do
        contents[idx] = string.format("%d %s", idx, marked_files[idx])
    end

    vim.api.nvim_buf_set_lines(bufh, 0, #contents, false, contents)
end

M.add_file = function() 
    local buf_name = vim.fn.bufname(vim.fn.bufnr())
    if get_index_of(buf_name) ~= nil then
        -- we don't alter file layout.
        return
    end

    for idx = 1, #marked_files do
        if marked_files[idx] == nil then
            marked_files[idx] = buf_name
            return
        end
    end

    table.insert(marked_files, buf_name)
end

M.swap = function(a, b) 
    a_idx = get_index_of(a)
    b_idx = get_index_of(b)

    if a_idx == nil or b_idx == nil then
        return
    end

    local tmp = marked_files[a_idx]
    marked_files[a_idx] = marked_files[b_idx]
    marked_files[b_idx] = tmp
end

M.rm_file = function(file) 
    idx = get_index_of(file)
    if idx == nil then
        return
    end

    marked_files[idx] = nil
end

M.nav_file = function(id) 

    if vim.api.nvim_win_is_valid(id) then
        vim.api.nvim_win_close(win_id)
    end

    idx = get_index_of(id)
    if idx == nil then
        return
    end

    local buf_id = vim.fn.bufnr(marked_files[idx])
    if buf_id ~= nil and buf_id ~= -1 then
        vim.api.nvim_set_current_buf(buf_id)
    else 
        vim.cmd(string.format("e %s", marked_files[idx]))
    end
end

return M

