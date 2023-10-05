-- Set space to leader key
vim.g.mapleader = " "
-- Set fat cursor
vim.opt.guicursor = ""
-- Set relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true
-- Line indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
-- Extend undo buffer
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- Highlighted word are not persistent 
vim.opt.hlsearch = false
-- Highlighting is incremental
vim.opt.incsearch = true
-- Terminal colors
vim.opt.termguicolors = true
-- Number of remaining lines while scrolling
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
-- Set update time
vim.opt.updatetime = 50
-- Set character stop
vim.opt.colorcolumn = "80"
-- Enable spell checking
vim.opt.spell = true

-- Enable vim to access system clipboard
--vim.opt.clipboard = "unnamedplus" 
