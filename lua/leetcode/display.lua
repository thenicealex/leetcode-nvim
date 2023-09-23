local M = {}

M.context = { "hello world" }

function M.create_window()
	local opts = {
		relative = "editor",
		width = math.floor(vim.o.columns * 0.5),
		height = 20,
		border = "rounded",
		row = math.floor(vim.o.lines * 0.1),
		col = math.floor(vim.o.columns) - math.floor(40),
		style = "minimal",
	}

	local bufnr = vim.api.nvim_create_buf(false, false)
	vim.bo[bufnr].bufhidden = "wipe"
	vim.bo[bufnr].buftype = "lcresult"
	local winid = vim.api.nvim_open_win(bufnr, true, opts)

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, M.context)
	-- vim.bo[bufnr].modifiable = false

	vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "", {
		noremap = true,
		nowait = true,
		callback = function()
			vim.api.nvim_win_close(winid, true)
		end,
	})
	return {winid = winid, bufnr = bufnr}
end

function M.toggle()
	if M.winid and vim.api.nvim_win_is_valid(M.winid) then
		vim.api.nvim_win_close(M.winid, true)
		M.winid = nil
		return
	end
	M.winid= M.create_window().winid
end

function M.set_context(context)
	if context == nil then
		return
	end
	M.context = context
end

return M
