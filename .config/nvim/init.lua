require("config.lazy")

-- General settings
vim.o.number = true
vim.o.backspace = "indent,eol,start"

-- Indent
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.autoindent = true

-- Tab visualization
vim.o.list = true
vim.o.listchars = "tab:▸ ,trail:·,nbsp:␣,extends:>,precedes:<"
