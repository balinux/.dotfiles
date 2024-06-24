-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- hotkey pindah ke atas dan ke bawah beberapa baris
vim.api.nvim_set_keymap("n", "<C-k>", "5k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "5j", { noremap = true, silent = true })
