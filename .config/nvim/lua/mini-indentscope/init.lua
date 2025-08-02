return {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
        -- 現在スコープのハイライト設定（オレンジ、太字）
        vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#FFAA00", bold = true })
        
        -- mini.indentscope設定（現在のスコープハイライト）
        require("mini.indentscope").setup({
            symbol = "│",
            options = {
                border = "both",
                indent_at_cursor = true,
                try_as_border = true,
            },
            draw = {
                delay = 50,
                animation = function() return 0 end,
            },
            mappings = {
                object_scope = "",
                object_scope_with_border = "",
                goto_top = "",
                goto_bottom = "",
            },
        })
        
        -- 特定のファイルタイプで無効化
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "help", "alpha", "dashboard", "neo-tree", "Trouble", 
                "lazy", "mason", "notify", "toggleterm", "lazyterm",
                "fzf", "startify", "fern"
            },
            callback = function()
                vim.b.miniindentscope_disable = true
            end,
        })
    end
}
