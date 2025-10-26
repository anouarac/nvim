local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

local function get_netrw_dir()
  local dir = vim.fn.expand("%:p")
  if vim.fn.isdirectory(dir) == 0 then
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return dir
end

-- Telescope find_files from netrw dir
vim.keymap.set('n', '<leader>pn', function()
  if vim.bo.filetype == "netrw" then
    builtin.find_files({
      cwd = get_netrw_dir()
    })
  else
    print("Not in netrw")
  end
end, { desc = 'Telescope find files from netrw dir'})

-- Telescope live_grep from netrw dir
vim.keymap.set('n', '<leader>gn', function()
  if vim.bo.filetype == "netrw" then
    builtin.live_grep({
      cwd = get_netrw_dir()
    })
  else
    print("Not in netrw")
  end
end, { desc = 'Telescope live grep from netrw dir'})

-- Fuzzy search in current buffer
vim.keymap.set('n', '<leader>ff', builtin.current_buffer_fuzzy_find, { desc = 'Telescope fuzzy find in buffer' })
