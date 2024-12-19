local sqlite3 = require("sqlite3")

local db_path = vim.fn.stdpath("data") .. "snippets.db"
local db = sqlite3.open(db_path)

local M = {}

function M.initialize()
  local schema = [[
        CREATE TABLE IF NOT EXISTS snippets (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            code TEXT NOT NULL,
            description TEXT,
            tags TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
    ]]
  db.exec(schema)
end

function M.save_snippet(name, code, description, tags)
  local stmt = db.prepare("INSERT INTO snippets (name, code, description, tags) VALUES (?, ?, ?, ?)")
  stmt:bind_values(name, code, description, tags)
  stmt:stepn()
  stmt:finalize()
end

function M.get_snippets(query)
  local stmt = db:prepare("SELECT * FROM snippets WHERE name LIKE ? OR tags LIKE ?")
  stmt:bind_values("%" .. query .. "%", "%" .. query .. "%")

  local results = {}
  for row in stmt:nrows() do
    table.insert(results, row)
  end

  stmt:finalize()
  return results
end

function M.delete_snippet(id)
  local stmt = db:prepare("DELETE FROM snippets WHERE id = ?")
  stmt:bind_values(id)
  stmt:step()
  stmt:finalize()
end
return M
