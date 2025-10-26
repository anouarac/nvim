local M = { A = nil, B = nil}

local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local function fnameescape(p) return vim.fn.fnameescape(p) end
local function to_dir(p) if vim.fn.isdirectory(p) == 1 then return p end return vim.fn.fnamemodify(p, ':h') end
local function set_side(side, path) local d = to_dir(path) if side == 'A' then M.A = d else M.B = d end vim.notify(side .. ' = ' .. d) end

local function netrw_dir()
  if vim.bo.filetype ~= 'netrw' then return nil end
  local d = vim.b.netrw_curdir or vim.fn.expand('%:p')
  if vim.fn.isdirectory(d) == 0 then d = vim.fn.fnamemodify(d, ':h') end
  return d
end

local fd_cmd = {
  "fd","--type","f","--type","d","--hidden",
  "--exclude","build/"
}

local function pick_path(side)
  builtin.find_files({
    no_ignore = true,
    hidden = true,
    find_command = fd_cmd,
    attach_mappings = function(_, map)
      local function choose(prompt_bufnr)
        local sel = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local p = (sel and (sel.path or sel.filename)) or ""
        if p ~= "" then set_side(side, p) end
      end
      map('i','<CR>', choose)
      map('n','<CR>', choose)
      return true
    end
  })
end

local function pick_A() pick_path('A') end
local function pick_B() pick_path('B') end

local function set_A_netrw() local d = netrw_dir() if d then set_side('A', d) else vim.notify('Not in netrw', vim.log.levels.WARN) end end
local function set_B_netrw() local d = netrw_dir() if d then set_side('B', d) else vim.notify('Not in netrw', vim.log.levels.WARN) end end

local function run_diff()
  if not (M.A and M.B) then vim.notify('Missing A or B', vim.log.levels.WARN) return end
  vim.cmd('ZFDirDiff ' .. fnameescape(M.A) .. ' ' .. fnameescape(M.B))
end

local function swap_sides() M.A, M.B = M.B, M.A vim.notify('Swapped: A=' .. tostring(M.A) .. ' B=' .. tostring(M.B)) end

vim.keymap.set('n','<leader>za', pick_A, { desc = 'DirDiff: pick A (Telescope)' })
vim.keymap.set('n','<leader>zb', pick_B, { desc = 'DirDiff: pick B (Telescope)' })
vim.keymap.set('n','<leader>zd', run_diff, { desc = 'DirDiff: run' })
vim.keymap.set('n','<leader>zs', swap_sides, { desc = 'DirDiff: swap A/B' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set('n','<leader>za', set_A_netrw, opts)
    vim.keymap.set('n','<leader>zb', set_B_netrw, opts)
  end
})
