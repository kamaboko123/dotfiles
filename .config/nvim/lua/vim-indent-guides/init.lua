return{
    "nathanaelkane/vim-indent-guides",
    config = function()
        vim.g.indent_guides_enable_on_vim_startup = 1
        vim.g.indent_guides_auto_colors = 1
        vim.g.indent_guides_guide_size = 1
    end,
}
