local M = {}
local runner = require("leetcode.runner")

local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event

function M.dispay()
	local file_path = vim.fn.expand("%:p")
	local popup = Popup({
		enter = false,
		focusable = false,
		border = {
			style = "rounded",
		},
		position = "50%",
		size = {
			width = "80%",
			height = "60%",
		},
	})

	-- mount/open the component
	popup:mount()

	-- unmount component when cursor leaves buffer
	popup:on(event.BufLeave, function()
		popup:unmount()
	end)
	vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { "Testing" })
	local context = runner.test(file_path)
	vim.api.nvim_buf_set_lines(popup.bufnr, 1, -1, false, context)

end

return M
