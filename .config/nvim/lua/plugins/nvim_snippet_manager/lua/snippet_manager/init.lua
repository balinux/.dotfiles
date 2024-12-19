-- local db = require("snippet_manager.db")
local db = require("plugins.nvim_snippet_manager.lua.snippet_manager.db")

local M = {}
-- setup
db.initialize()
return M
