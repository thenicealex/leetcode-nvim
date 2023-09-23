local M = {}
local display = require("leetcode.display")
local que = require("leetcode.questions")

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

function M.list_all()
	local question_all = que.filter_problems().result_str
	vim.cmd("vsplit")
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_win_set_buf(win, buf)
	for _, value in pairs(question_all) do
		vim.api.nvim_buf_set_lines(buf, -1, -1, true, { value })
	end
end

return M
