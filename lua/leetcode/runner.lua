local M = {}
local display = require("leetcode.display")

function M.test()
	local file_path = vim.fn.expand("%:p")
	local bufnr = display.create_window().bufnr
	---@diagnostic disable-next-line: unused-local
	local job_id = vim.fn.jobstart("leetcode test " .. file_path, {
		stdout_buffered = true,
		on_stdout = function(_, data, _)
			local start = vim.api.nvim_buf_line_count(bufnr)
			if start == 1 and #vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)[1] == 0 then
				start = start - 1
			end
			vim.api.nvim_buf_set_lines(bufnr, start, -1, false, data)
		end,
		on_exit = function(_, code, _)
			vim.bo[bufnr].modifiable = false
			-- if code == 0 then
			-- 	vim.api.nvim_out_write("LeetCode test ok。\n")
			-- else
			-- 	vim.api.nvim_err_write("LeetCode test not ok。\n")
			-- end
		end,
	})
end

function M.submit()
	local file_path = vim.fn.expand("%:p")
	local bufnr = display.create_window().bufnr
	local job_id = vim.fn.jobstart("leetcode submit " .. file_path, {
		stdout_buffered = true,
		on_stdout = function(_, data, _)
			local start = vim.api.nvim_buf_line_count(bufnr)
			if start == 1 and #vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)[1] == 0 then
				start = start - 1
			end
			vim.api.nvim_buf_set_lines(bufnr, start, -1, false, data)
		end,
		on_exit = function(_, code, _)
			vim.bo[bufnr].modifiable = false
			-- if code == 0 then
			-- 	vim.api.nvim_out_write("LeetCode test ok。\n")
			-- else
			-- 	vim.api.nvim_err_write("LeetCode test not ok。\n")
			-- end
		end,
	})
end

return M
