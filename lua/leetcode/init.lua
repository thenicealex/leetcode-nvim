local M = {}

function M.setup(opts)
  local cfg = require("leetcode.config")
  local command = require("leetcode.command")

  cfg.config = vim.tbl_extend("force", cfg.default_config, opts or {})
  command.init()
end

return M
