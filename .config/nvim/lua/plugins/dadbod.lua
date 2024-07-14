-- -- dadbod digunakan untuk remote database dari nvim
-- return {
--   { "tpope/vim-dadbod" },
--   {
--     "kristijanhusak/vim-dadbod-ui",
--     dependencies = {
--       { "tpope/vim-dadbod", lazy = true },
--       { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
--     },
--     cmd = {
--       "DBUI",
--       "DBUIToggle",
--       "DBUIAddConnection",
--       "DBUIFindBuffer",
--     },
--     init = function()
--       -- Your DBUI configuration
--       vim.g.db_ui_use_nerd_fonts = 1
--     end,
--   },
--   -- { "kristijanhusak/vim-dadbod-completion" },
-- }

return {
  -- Add vim-dadbod, vim-dadbod-ui, and vim-dadbod-completion
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      -- Dadbod UI keybindings
      vim.g.dbs = {
        my_database = "mysql://root:1234Usd!@127.0.0.1:3306",
        techinfaq = "mysql://root:1234Usd!@127.0.0.1:3306/techinfaq",
      }
      -- vim.api.nvim_set_keymap("n", "<leader>du", ":DBUIToggle<CR>", { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap("n", "<leader>df", ":DBUIFindBuffer<CR>", { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap("n", "<leader>dr", ":DBUIRenameBuffer<CR>", { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap("n", "<leader>dl", ":DBUILastQueryInfo<CR>", { noremap = true, silent = true })

      -- SQL filetype specific settings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
        end,
      })
    end,
  },
}
