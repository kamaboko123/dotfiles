return {
    "lambdalisue/vim-fern",
    dependencies = {},
    config= function()
        nvim_config_dir = vim.fn.stdpath("config")
        fern_config_dir = nvim_config_dir .. "/lua/fern"
        vim.cmd([[source]] .. fern_config_dir .. "/config.vim")
        
        -- Ctrl + eで開閉
        vim.keymap.set("n", "<C-e>", ":Fern . -drawer -toggle -width=40 <CR>", { noremap = true, silent = true })
        
        -- keymapの設定
        vim.g['fern#disable_default_mappings'] = 1
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'fern',
            callback = function()
                local opts = { buffer = true, silent = true }
                --vim.keymap.set('n', '<l>', '<Plug>(fern-action-expand-tree:stay)', opts)
                
                -- lでディレクトリを展開
                vim.keymap.set('n', 'l', function()
                    -- ファイルかディレクトリかで挙動を変える(expandだとファイルを開いてしまう)
                    local expr = vim.fn["fern#smart#leaf"](
                        "<Nop>", -- ファイルの場合は何もしない
                        "<Plug>(fern-action-expand:stay)" -- ディレクトリの場合は展開する
                    )
                    if expr == "<Nop>" then
                        return
                    end
                    vim.api.nvim_feedkeys(
                        vim.api.nvim_replace_termcodes(expr, true, false, true),
                        'n', false
                    )
                end, opts)
                
                -- Ctrl + lでディレクトリに移動
                vim.keymap.set('n', '<C-l>', function()
                    local expr = vim.fn["fern#smart#leaf"](
                        "<Nop>",
                        "<Plug>(fern-action-open)"
                    )
                    if expr == "<Nop>" then
                        return
                    end
                    vim.api.nvim_feedkeys(
                        vim.api.nvim_replace_termcodes(expr, true, false, true),
                        'n', false
                    )
                end, opts)

                -- hでディレクトリを閉じる
                vim.keymap.set('n', 'h', '<Plug>(fern-action-collapse)', opts)
                vim.keymap.set('n', '<C-h>', '<Plug>(fern-action-leave)', opts)

                vim.keymap.set('n', '<CR>', function()
                    local expr = vim.fn["fern#smart#leaf"](
                        "<Plug>(fern-action-open:drop)",
                        "<Nop>"
                    )
                    if expr == "<Nop>" then
                        return
                    end
                    vim.api.nvim_feedkeys(
                        vim.api.nvim_replace_termcodes(expr, true, false, true),
                        'n', false
                    )
                end, opts)

                -- 隠しファイルの表示切り替え
                vim.keymap.set('n', 'I', '<Plug>(fern-action-hidden:toggle)', opts)

                -- リロード
                vim.keymap.set('n', 'R', '<Plug>(fern-action-reload:all)', opts)

                -- ファイルバッファの開き方(NerdTreeと同じ)
                vim.keymap.set('n', 'v', '<Plug>(fern-action-open:vsplit)', opts)
                vim.keymap.set('n', 's', '<Plug>(fern-action-open:split)', opts)
            end,
        })

        -- nvimの設定ディレクトリを開く
        vim.api.nvim_create_user_command(
            'ConfigureNvim',
            function()
                vim.cmd('Fern ~/.config/nvim -drawer')
            end,
            {}
        )
    end,
}
