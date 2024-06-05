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
  end,
}
