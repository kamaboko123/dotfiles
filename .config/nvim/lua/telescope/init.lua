return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
        -- For live grep functionality, we need to have ripgrep installed.
        -- `sudo apt install ripgrep`
        vim.keymap.set('n', '<C-f>', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })
    end
}
