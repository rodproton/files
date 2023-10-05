local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.setup()
vim.diagnostic.config({
    virtual_text = true
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}
    -- Rename references
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    -- Perform code actions
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    -- Lists all symbols in the current workspace
    vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
end)
