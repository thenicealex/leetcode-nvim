local M = {}
local result = {}

function M.test()
	local file_path = vim.fn.expand("%:p")
	-- print(file_path)
	local command = [[
  let file_path = expand("%:p")
  call jobstart("leetcode test ".file_path, {'on_stdout':{j,d,e->append(line('.'),d)}})]]
	vim.cmd(command)
	local Split = require("nui.split")
	local event = require("nui.utils.autocmd").event

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
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {"Testing"})

	--  local file_path = vim.fn.expand("%:p")
	-- local file_name = vim.fn.fnamemodify(file_path, ":t")
	-- local output = vim.fn.systemlist("leetcode test " .. file_path)
	-- if output == nil then
	-- 	return
	-- end
	-- for _, value in pairs(output) do
	-- 	if value:find("Warning") or value:find("warning") then
	-- 		goto continue
	-- 	end
	-- 	table.insert(result, value)
	-- 	::continue::
	-- end
	-- for _, value in pairs(result) do
	-- 	print(value)
	-- end
	--  return result
end

function M.submit()
	local command = [[
  let file_path = expand("%:p")
  call jobstart("leetcode test ".file_path, {'on_stdout':{j,d,e->append(line('.'),d)}})]]
	vim.cmd(command)
	local Split = require("nui.split")
	local event = require("nui.utils.autocmd").event

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
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {"Submitting"})
	-- local file_path = vim.fn.expand("%:p")
	-- local file_name = vim.fn.fnamemodify(file_path, ":t")
	-- local output = vim.fn.systemlist("leetcode submit " .. file_path)
	-- if output == nil then
	-- 	return
	-- end
	-- for _, value in pairs(output) do
	-- 	if value:find("Warning") or value:find("warning") then
	-- 		goto continue
	-- 	end
	-- 	table.insert(result, value)
	-- 	::continue::
	-- end
	-- -- for _, value in pairs(result) do
	-- -- 	print(value)
	-- -- end
	-- return result
end

return M
