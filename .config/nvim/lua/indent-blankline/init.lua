return{
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
    },
    config = function()
        -- ハイライトグループを設定（基本のインデント線のみ）
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3C3C3C" })  -- 通常のインデント線（薄いグレー）
        
        require("ibl").setup{
            indent = {
                char = "│",
                tab_char = "│",
                highlight = "IblIndent",
            },
            scope = {
                enabled = false,  -- スコープ機能は無効（mini.indentscopeに任せる）
            },
            exclude = {
                filetypes = {
                    "help", "alpha", "dashboard", "neo-tree", "Trouble",
                    "lazy", "mason", "notify", "toggleterm", "lazyterm",
                },
            },
        }
    end
}
