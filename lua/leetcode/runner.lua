local M = {}
local Split = require("nui.split")
local event = require("nui.utils.autocmd").event
local result = ""

local function display(task)
	local split = Split({
		relative = "editor",
		position = "right",
		size = "40%",
		buf_options = {
			buftype = "nofile",
			swapfile = false,
			filetype = "leetcode",
		},
		win_options = {
			winblend = 10,
			wrap = false,
			number = false,
			relativenumber = false,
			signcolumn = "no",
			foldmethod = "manual",
			foldenable = false,
			cursorcolumn = false,
			list = false,
			winhighlight = "NormalFloat:Normal",
		},
	})

	-- mount/open the component
	split:mount()

	-- unmount component when cursor leaves buffer
	split:on(event.BufLeave, function()
		split:unmount()
	end)
	vim.api.nvim_buf_set_lines(0, 0, -1, false, { task })
end

function M.test()
	local file_path = vim.fn.expand("%:p")
	local job_id = vim.fn.jobstart("leetcode test " .. file_path, {
    stdout_buffered = true,
		on_stdout = function(_, data, _)
      vim.fn.append(vim.fn.line('.'), data)
		end,
		on_exit = function(_, code, _)
			-- if code == 0 then
			-- 	vim.api.nvim_out_write("LeetCode test ok。\n")
			-- else
			-- 	vim.api.nvim_err_write("LeetCode test not ok。\n")
			-- end
		end,
	})
	display("Testing")
end

function M.submit()
	local file_path = vim.fn.expand("%:p")
	local job_id = vim.fn.jobstart("leetcode submit " .. file_path, {
    stdout_buffered = true,
		on_stdout = function(_, data, _)
      vim.fn.append(vim.fn.line('.'), data)
		end,
		on_exit = function(_, code, _)
			-- if code == 0 then
			-- 	vim.api.nvim_out_write("LeetCode test ok。\n")
			-- else
			-- 	vim.api.nvim_err_write("LeetCode test not ok。\n")
			-- end
		end,
	})
	display("Testing")
end

return M
