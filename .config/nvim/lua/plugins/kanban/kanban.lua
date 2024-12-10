-- kanban.lua

local M = {}

-- Default board
M.board = {
  TODO = {},
  ["In Progress"] = {},
  Done = {},
}

-- Fungsi untuk membuat buffer baru untuk Kanban
function M.open_kanban()
  -- Buat buffer baru
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"

  -- Tampilkan buffer di window baru
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.8),
    col = math.floor(vim.o.columns * 0.1),
    row = math.floor(vim.o.lines * 0.1),
    border = "rounded",
  })

  -- Render Kanban
  M.render_board(buf)
end

-- Fungsi untuk me-render board
function M.render_board(buf)
  local lines = {}

  -- Tambahkan header untuk setiap kolom
  for column, items in pairs(M.board) do
    table.insert(lines, string.format("# %s", column))
    for _, item in ipairs(items) do
      table.insert(lines, string.format("- %s", item))
    end
    table.insert(lines, "") -- Tambahkan baris kosong antara kolom
  end

  -- Set isi buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

-- Fungsi untuk menambahkan item ke kolom tertentu
function M.add_item(column, item)
  if M.board[column] then
    table.insert(M.board[column], item)
  else
    print(string.format("Kolom '%s' tidak ditemukan!", column))
  end
end

-- Fungsi untuk memindahkan item antar kolom
function M.move_item(from_column, to_column, index)
  if M.board[from_column] and M.board[to_column] and M.board[from_column][index] then
    local item = table.remove(M.board[from_column], index)
    table.insert(M.board[to_column], item)
  else
    print("Operasi pemindahan gagal. Periksa input Anda.")
  end
end

-- Buat perintah untuk membuka Kanban Board
vim.api.nvim_create_user_command("KanbanOpen", M.open_kanban, { desc = "Open the Kanban Board" })

-- Buat perintah untuk menambahkan item
vim.api.nvim_create_user_command("KanbanAdd", function(opts)
  local args = vim.split(opts.args, " ", { plain = true })
  local column = args[1]
  local item = table.concat(args, " ", 2)
  M.add_item(column, item)
end, { nargs = "+", desc = "Add an item to the Kanban Board. Usage: KanbanAdd <column> <item>" })

-- Buat perintah untuk memindahkan item
vim.api.nvim_create_user_command("KanbanMove", function(opts)
  local args = vim.split(opts.args, " ", { plain = true })
  local from_column = args[1]
  local to_column = args[2]
  local index = tonumber(args[3])
  M.move_item(from_column, to_column, index)
end, { nargs = 3, desc = "Move an item between columns. Usage: KanbanMove <from_column> <to_column> <index>" })

return M
