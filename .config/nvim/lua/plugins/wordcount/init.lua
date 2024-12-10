-- init.lua

-- Fungsi untuk menghitung jumlah kata
local function count_words()
  -- Ambil isi buffer saat ini
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Gabungkan semua baris menjadi satu string
  local content = table.concat(lines, " ")

  -- Hitung jumlah kata
  local word_count = 0
  for _ in content:gmatch("%S+") do
    word_count = word_count + 1
  end

  -- Tampilkan hasil di baris status
  vim.api.nvim_echo({ { string.format("Word Count: %d", word_count), "Normal" } }, false, {})
end

-- Buat perintah Neovim baru untuk menghitung kata
vim.api.nvim_create_user_command(
  "WordCount", -- Nama perintah
  count_words, -- Fungsi yang dijalankan
  { desc = "Count words in the current buffer" } -- Deskripsi
)
