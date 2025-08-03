require("config.lazy")

-- General settings
vim.o.number = true
vim.o.backspace = "indent,eol,start"
vim.o.wrap = false

-- Tab visualization
vim.o.list = true
vim.o.listchars = "tab:▸ ,trail:·,nbsp:␣,extends:>,precedes:<"

-- Open with last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
})

-- clipboard support with OSC52
vim.g.clipboard = 'osc52'

-- Indent
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.autoindent = true

-- Indent config for filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "java", "javascript", "typescript", "python", "lua", "go", "lua" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = true
    vim.opt_local.smarttab = true
    vim.opt_local.autoindent = true
  end,
})


