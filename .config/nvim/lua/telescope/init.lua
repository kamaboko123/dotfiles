return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        -- filename serch
        vim.keymap.set('n', '<M-F>', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })

        -- For live grep functionality, we need to have ripgrep installed.
        -- `sudo apt install ripgrep`
        vim.keymap.set('n', '<M-f>', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })

        -- buffer search
        vim.keymap.set('n', '<M-b>', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })
    end
}
