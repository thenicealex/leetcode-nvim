local M = {}

function M.setup(opts)
	local default_config = require("leetcode.default_config")
	local command = require("leetcode.command")

	M.conf = vim.tbl_extend("force", default_config, opts or {})
	command.init()
end

return M
