-- Set space as leader key
vim.g.mapleader = " "
-- File tree command
vim.keymap.set("n", "<leader>pp", vim.cmd.Ex)
-- Open terminal 
vim.api.nvim_set_keymap("n", "<leader>tt", [[:let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>cd $VIM_DIR<CR>]], { noremap = true, silent = true })
-- Move block of text
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- Using capital J to move bottom line in front of current
vim.keymap.set("n", "J", "mzJ`z")
-- Keep cursor in the middle of the screen while navigating file
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Keep cursor in the middle of the screen while searching for term
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Maintain first selected word
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Yank from vim to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- Delete selected text without saving to main register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
