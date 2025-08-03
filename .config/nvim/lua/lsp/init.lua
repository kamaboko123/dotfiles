return{
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim", opts={} },
        "neovim/nvim-lspconfig",
    },
    opts = {
        ensure_installed = {
            "lua_ls",
            "gopls",
            "pyright",
            "rust_analyzer",
        }
    },
    config = function()
        vim.lsp.enable("lua_ls")
        vim.lsp.enable("gopls")

        vim.keymap.set('n', 'gd', '<cmd>:lua vim.lsp.buf.definition()<CR>')
    end,
}
