return{
    "preservim/nerdtree",
    config = function()
        vim.g.NERDTreeWinSize = 40
        vim.keymap.set("n", "<C-e>", ":NERDTreeToggle<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<C-n>", ":NERDTree<CR>", { noremap = true, silent = true })

        -- nvimの設定ディレクトリを開く
        vim.api.nvim_create_user_command(
            'ConfigureNvim',
            function()
                vim.cmd('NERDTree ~/.config/nvim')
            end,
            {}
        )
    end,
}
