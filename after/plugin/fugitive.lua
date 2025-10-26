vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
    group = ThePrimeagen_Fugitive,
    pattern = "*",
    callback = function()
        if vim.bo.ft ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = {buffer = bufnr, remap = false}
        vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git('push')
        end, opts)

        -- rebase always
        vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git({'pull',  '--rebase'})
        end, opts)

        -- NOTE: It allows me to easily set the branch i am pushing and any tracking
        -- needed if i did not set the branch up correctly
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
    end,
})
vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit!<CR>")
vim.keymap.set("n", "<leader>gq", ":diffoff!<CR>")
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>")
vim.keymap.set("n", "<leader>gl", ":Gclog<CR>")
vim.keymap.set("n", "<leader>gw", ":Gwrite<CR>")
vim.keymap.set("n", "<leader>gR", ":Gread<CR>")
vim.keymap.set("n", "<leader>gT", ":Git difftool -y<CR>")
vim.keymap.set("n", "<leader>gm", ":Git mergetool<CR>")
vim.keymap.set("n", "<leader>gB", ":Git blame<CR>")
vim.keymap.set("n", "<leader>gL", ":Gclog<CR>")

vim.keymap.set("n", "<leader>gu", ":<cmd>diffget //2<CR>")
vim.keymap.set("n", "<leader>gh", ":<cmd>diffget //3<CR>")

