return{
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim", opts={} },
        "neovim/nvim-lspconfig",
    },
    opts = {
        ensure_installed = {
            "copilot",
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
        vim.keymap.set('n', 'gD', '<cmd>:lua vim.lsp.buf.declaration()<CR>')

        vim.keymap.set('n', 'gl', '<cmd>:lua vim.diagnostic.setloclist()<CR>')

        vim.keymap.set('n', '<C-j>', function()
            vim.diagnostic.goto_next({ float = false })
        end)
        vim.keymap.set('n', '<C-k>', function()
            vim.diagnostic.goto_prev({ float = false })
        end)


        vim.keymap.set('n', '<C-a>', '<cmd>:lua vim.lsp.buf.code_action()<CR>')

        local auto_diagnostic_show_enabled = true
        vim.keymap.set('n', 'gh', function()
            auto_diagnostic_show_enabled = not auto_diagnostic_show_enabled
            if auto_diagnostic_show_enabled then
                vim.notify("Auto diagnostic show enabled")
            else
                vim.notify("Auto diagnostic show disabled")
            end
        end)


        vim.opt.updatetime = 500
        -- カーソルが一定時間停止したら自動でdiagnosticを表示
        vim.api.nvim_create_autocmd("CursorHold", {
            buffer = bufnr,
            callback = function()
                local opts = {
                    focusable = false,
                    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                    border = 'rounded',
                    source = 'always',
                    prefix = ' ',
                    scope = 'cursor',
                }
                if auto_diagnostic_show_enabled then
                    vim.diagnostic.open_float(nil, opts)
                end
            end
        })

    end,
}
