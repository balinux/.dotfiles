local M = {}

-- Default board
M.board = {
  TODO = {},
  InProgress = {},
  Done = {},
}

-- Fungsi untuk memuat dari file TODO.md
local function load_from_todo_md(filepath)
  local board = { TODO = {}, InProgress = {}, Done = {} }
  local current_column = nil

  local file = io.open(filepath, "r")
  if file then
    for line in file:lines() do
      if line:match("^#") then
        current_column = line:match("^#%s*(.+)")
      elseif line:match("^-") and board[current_column] then
        local item = line:match("^- (.+)")
        table.insert(board[current_column], item)
      end
    end
    file:close()
  else
    print("File " .. filepath .. " tidak ditemukan, membuat file baru...")
    file = io.open(filepath, "w")
    local file = io.open(filepath, "w")
    if file then
      file:write("# TODO\n\n# InProgress\n\n# Done\n")
      file:close()
    else
      print("Error: Unable to create or write to file at " .. filepath)
    end
  end
  M.board = board
end

-- Fungsi untuk menyimpan ke file TODO.md
local function save_to_todo_md(filepath)
  local file = io.open(filepath, "w")
  if file then
    for column, items in pairs(M.board) do
      file:write("# " .. column .. "\n")
      for _, item in ipairs(items) do
        file:write("- " .. item .. "\n")
      end
      file:write("\n")
    end
    file:close()
    print("Kanban board disimpan ke " .. filepath)
  else
    print("Tidak bisa menyimpan ke file " .. filepath)
  end
end

-- Path default untuk TODO.md
local filepath = vim.fn.stdpath("config") .. "/TODO.md"

-- Fungsi untuk membuka Kanban
function M.open_kanban()
  load_from_todo_md(filepath)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.8),
    col = math.floor(vim.o.columns * 0.1),
    row = math.floor(vim.o.lines * 0.1),
    border = "rounded",
  })

  M.render_board(buf)
end

-- Fungsi untuk me-render Kanban
function M.render_board(buf)
  local lines = {}
  for column, items in pairs(M.board) do
    table.insert(lines, string.format("# %s", column))
    for _, item in ipairs(items) do
      table.insert(lines, string.format("- %s", item))
    end
    table.insert(lines, "")
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

-- Fungsi untuk menambahkan item
function M.add_item(column, item)
  if M.board[column] then
    table.insert(M.board[column], item)
  else
    print(string.format("Kolom '%s' tidak ditemukan!", column))
  end
end

-- Fungsi untuk memindahkan item
function M.move_item(from_column, to_column, index)
  if M.board[from_column] and M.board[to_column] and M.board[from_column][index] then
    local item = table.remove(M.board[from_column], index)
    table.insert(M.board[to_column], item)
  else
    print("Operasi pemindahan gagal. Periksa input Anda.")
  end
end

-- Perintah
vim.api.nvim_create_user_command("KanbanLoad", function()
  load_from_todo_md(filepath)
  print("Kanban board dimuat dari " .. filepath)
end, { desc = "Load kanban board from TODO.md" })

vim.api.nvim_create_user_command("KanbanSave", function()
  save_to_todo_md(filepath)
end, { desc = "Save kanban board to TODO.md" })

-- perintah auto-save setiap buffer di perbaharui
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "TODO.md",
  callback = function()
    print("Auto-saving Kanban Board to TODO.md...")
    save_to_todo_md(filepath)
  end,
  desc = "auto-save kanban board to TODO.md on buffer write",
})

vim.api.nvim_create_user_command("KanbanOpen", M.open_kanban, { desc = "Open the Kanban Board" })

vim.api.nvim_create_user_command("KanbanAdd", function(opts)
  local args = vim.split(opts.args, " ", { plain = true })
  local column = args[1]
  local item = table.concat(args, " ", 2)
  M.add_item(column, item)
end, { nargs = "+", desc = "Add an item to the Kanban Board. Usage: KanbanAdd <column> <item>" })

vim.api.nvim_create_user_command("KanbanMove", function(opts)
  local args = vim.split(opts.args, " ", { plain = true })

  -- Memastikan ada tiga argumen
  if #args ~= 3 then
    print("Perintah KanbanMove membutuhkan tiga argumen: <from_column> <to_column> <index>")
    return
  end

  local from_column = args[1]
  local to_column = args[2]
  local index = tonumber(args[3])

  -- Validasi index dan kolom
  if from_column and to_column and index then
    M.move_item(from_column, to_column, index)
  else
    print("Argumen tidak valid. Pastikan <from_column>, <to_column>, dan <index> diberikan dengan benar.")
  end
end, { nargs = "*", desc = "Move an item between columns. Usage: KanbanMove <from_column> <to_column> <index>" })

return M
