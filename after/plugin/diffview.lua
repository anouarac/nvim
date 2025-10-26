require('diffview').setup({})

local map = vim.keymap.set
map("n", "<leader>gv", ":DiffviewOpen<CR>")
map("n", "<leader>gV", ":DiffviewClose<CR>")
map("n", "<leader>gr", ":DiffviewRefresh<CR>")
map("n", "<leader>gf", ":DiffviewFocusFiles<CR>")
map("n", "<leader>gt", ":DiffviewToggleFiles<CR>")
map("n", "<leader>gh", ":DiffviewFileHistory %<CR>")
map("n", "<leader>gH", ":DiffviewFileHistory<CR>")
map("v", "<leadeh>gh", ":'<,'>DiffviewFileHistory %<CR>")
