return {
  "uga-rosa/ccc.nvim",
  config = function()
    require("ccc").setup({
      -- Add any specific configuration options for ccc.nvim here
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    })
    -- Key mappings for ccc.nvim
    vim.api.nvim_set_keymap("n", "<leader>cp", "<cmd>CccPick<CR>", { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '<leader>cc', '<cmd>CccConvert<CR>', { noremap = true, silent = true })
    --  vim.api.nvim_set_keymap('n', '<leader>cm', '<cmd>CccHighlighterToggle<CR>', { noremap = true, silent = true })
  end,
}
