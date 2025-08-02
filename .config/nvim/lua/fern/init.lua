return {
    "lambdalisue/vim-fern",
    dependencies = {},
    config= function()
        nvim_config_dir = vim.fn.stdpath("config")
        fern_config_dir = nvim_config_dir .. "/lua/fern"
        vim.cmd([[source]] .. fern_config_dir .. "/config.vim")
        
        -- trashコマンドが存在するか確認する
        -- ファイル削除は基本的にtrashを使う
        function check_trash_command()
            local trash_command = vim.fn.system("which trash")
            if vim.v.shell_error ~= 0 then
                return false
            end
            return true
        end

        -- Ctrl + eで開閉
        vim.keymap.set("n", "<C-e>", ":Fern . -toggle -drawer -width=40<CR>", { silent = true })
        
        -- keymapの設定
        vim.g['fern#disable_default_mappings'] = 1
        vim.api.nvim_create_autocmd('FileType', { --Fernのバッファ内でのキーマップ
            pattern = 'fern',
            callback = function()
                local opts = { buffer = true, silent = true } -- バッファローカルのオプション設定
                
                -- lでディレクトリを展開
                vim.keymap.set('n', 'l', function()
                    -- ファイルかディレクトリかで挙動を変える(expandだとファイルを開いてしまう)
                    local expr = vim.fn["fern#smart#leaf"](
                        "<Nop>", -- ファイルの場合は何もしない
                        "<Plug>(fern-action-expand:stay)", -- ディレクトリ(折りたたまれている)の場合は展開する
                        "<Plug>(fern-action-collapse)" -- ディレクトリ(展開されている)の場合は折りたたむ
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
                        "<Plug>(fern-action-expand:stay)",
                        "<Plug>(fern-action-collapse)"
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

                -- ファイル操作系
                -- new file
                vim.keymap.set('n', 'n', '<Plug>(fern-action-new-file)', opts)
                -- copy(clipboard)
                vim.keymap.set('n', 'yy', '<Plug>(fern-action-clipboard-copy)', opts)
                -- cut(clipboard)
                vim.keymap.set('n', 'dd', '<Plug>(fern-action-clipboard-cut)', opts)
                -- paste(clipboard)
                vim.keymap.set('n', 'p', '<Plug>(fern-action-clipboard-paste)', opts)
                -- rename
                vim.keymap.set('n', 'mm', '<Plug>(fern-action-rename)', opts)
                -- delete(trash)
                vim.keymap.set('n', 'xx', function()
                    if check_trash_command() then
                        vim.api.nvim_feedkeys(
                            vim.api.nvim_replace_termcodes(
                                '<Plug>(fern-action-trash)', true, false, true),
                            'n', false
                        )
                    else
                        vim.notify("Trash command not found. Please install 'trash' command. If you want to delete the file completely, use 'XX' instead of 'xx'", vim.log.levels.WARN)
                    end
                end, opts)
                -- delete(complete)
                vim.keymap.set('n', '<S-x><S-x>', '<Plug>(fern-action-remove)', opts)

            end,
        })

        -- nvimの設定ディレクトリを開く
        vim.api.nvim_create_user_command(
            'ConfigureNvim',
            function()
                vim.cmd('Fern ~/.config/nvim -drawer -width=40')
            end,
            {}
        )
    end,
}
