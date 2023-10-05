local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

--Add current file to harpoon
vim.keymap.set("n", "<leader>a", mark.add_file)
--Toggle quick menu
vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu)
-- Cycle through harpoon list
vim.keymap.set("n", "<C-k>", function() ui.nav_next() end)
vim.keymap.set("n", "<C-j>", function() ui.nav_prev() end)

--File navigation
--vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
--vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
--vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
--vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
