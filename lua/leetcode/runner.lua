local M = {}
local display = require("leetcode.display")

function M.test()
	local file_path = vim.fn.expand("%:p")
	---@diagnostic disable-next-line: unused-local
	local job_id = vim.fn.jobstart("leetcode test " .. file_path, {
		stdout_buffered = true,
		on_stdout = function(_, data, _)
			local current_line = vim.fn.line(".")
			if current_line ~= nil then
				vim.fn.append(current_line, data)
			end
		end,
		on_exit = function(_, code, _)
			-- if code == 0 then
			-- 	vim.api.nvim_out_write("LeetCode test ok。\n")
			-- else
			-- 	vim.api.nvim_err_write("LeetCode test not ok。\n")
			-- end
		end,
	})
	display.create_window()
end

function M.submit()
	local file_path = vim.fn.expand("%:p")
	local job_id = vim.fn.jobstart("leetcode submit " .. file_path, {
		stdout_buffered = true,
		on_stdout = function(_, data, _)
			local current_line = vim.fn.line(".")
			if current_line ~= nil then
				vim.fn.append(current_line, data)
			end
		end,
		on_exit = function(_, code, _)
			-- if code == 0 then
			-- 	vim.api.nvim_out_write("LeetCode test ok。\n")
			-- else
			-- 	vim.api.nvim_err_write("LeetCode test not ok。\n")
			-- end
		end,
	})
  display.create_window()
end

return M
