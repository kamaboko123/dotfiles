return{
    "rebelot/kanagawa.nvim",
    config = function()
        require('kanagawa').setup({
            compile = false,             -- enable compiling the colorscheme
            undercurl = true,            -- enable undercurls
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true},
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = false,         -- do not set background color
            dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
            terminalColors = true,       -- define vim.g.terminal_color_{0,17}
            colors = {                   -- add/modify theme and palette colors
                palette = {},
                theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
            },
            overrides = function(colors) -- add/modify highlights
                return {
                    WinSeparator = { fg = colors.theme.syn.constant, bg = "NONE" },  -- バッファの境界線をわかりやすく
                }
            end,
            theme = "wave",              -- Load "wave" theme
            background = {               -- map the value of 'background' option to a theme
                dark = "wave",           -- try "dragon" !
                light = "lotus"
            },
        })
        require("kanagawa").load("wave")
        --vim.cmd("highlight WinSeparator guifg=#ff9e64 guibg=NONE")
    end
}
