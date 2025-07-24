return{
    "github/copilot.vim",
    config = function()
        vim.g.copilot_no_tab_map = true
        vim.g.copilot_filetypes = {
            ["*"] = true,
        }
        vim.api.nvim_set_keymap("i", "<M-l>", 'copilot#AcceptWord()', { expr = true, silent = true })
        vim.api.nvim_set_keymap("i", "<M-L>", 'copilot#Accept()', { expr = true, silent = true })
        vim.api.nvim_set_keymap("i", "<M-j>", 'copilot#Next()', { expr = true, silent = true })
        vim.api.nvim_set_keymap("i", "<M-k>", 'copilot#Previous()', { expr = true, silent = true })
        vim.api.nvim_set_keymap("i", "<M-h>", 'copilot#Dismiss()', { expr = true, silent = true })
    end
}
