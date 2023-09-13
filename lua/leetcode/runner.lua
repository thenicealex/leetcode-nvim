local M = {}

function M.test()
	local file_path = vim.fn.expand("%:p")
	local file_name = vim.fn.fnamemodify(file_path, ":t")
	local output = vim.fn.systemlist("leetcode test " .. file_path)
	local result = {}
	if output == nil then
		return
	end
	for _, value in pairs(output) do
		if value:find("Warning") or value:find("warning") then
			goto continue
		end
		table.insert(result, value)
		::continue::
	end
	for key, value in pairs(result) do
		print(value)
	end
end

function M.submit()
	local file_path = vim.fn.expand("%:p")
	local file_name = vim.fn.fnamemodify(file_path, ":t")
	local output = vim.fn.systemlist("leetcode submit " .. file_path)
	local result = {}
	if output == nil then
		return
	end
	for _, value in pairs(output) do
		if value:find("Warning") or value:find("warning") then
			goto continue
		end
		table.insert(result, value)
		::continue::
	end
	for key, value in pairs(result) do
		print(value)
	end
end

return M
