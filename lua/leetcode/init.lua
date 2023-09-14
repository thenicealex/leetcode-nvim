local M = {}
local default_config = require("leetcode.default_config")
local questions = require("leetcode.questions")


function M.setup(opts)
	M.conf = vim.tbl_extend("force", default_config, opts or {})
	vim.keymap.set("n", "<localleader>lq", function()
		questions.tele_list()
	end, { silent = true, noremap = true, desc = "leetcode list" })
end

return M
