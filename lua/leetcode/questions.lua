local M = {}

local function is_id(value)
	return value:match("%[(.-)%]"):match("%d+")
end

local function is_staus(value)
	if value:find("√") then
		return "ac"
	elseif value:find("×") then
		return "tried"
	else
		return "notac"
	end
end

local function is_difficulty(value)
	if value:find("Easy") then
		return "Easy"
	elseif value:find("Medium") then
		return "Medium"
	else
		return "Hard"
	end
end

local function is_title(value)
	local c
	if value:find("Easy") then
		c = "Easy"
	elseif value:find("Medium") then
		c = "Medium"
	else
		c = "Hard"
	end
	if value:match("%](.-)%(") ~= nil then
		value = value:match("%](.-)%(")
	end
	if value:match("(.-) " .. c) ~= nil then
		value = value:match("(.-) " .. c)
	end
	local res, _ = value:gsub("^%s*(.-)%s*$", "%1")
	return res
end

function M.filter_problems()
	local problems = vim.fn.systemlist("leetcode list")
	if problems == nil then
		return { result = {}, result_tab = { { "nil", "nil", "nil", "nil", "nil" } } }
	end
	local result = {}
	local result_tab = {}
	for _, value in pairs(problems) do
		if value:find("Warning") or value:find("warning") then
			goto continue
		end
    if value:match("%[(.-)%]"):find("LC") then
			goto continue
    end
		local id = is_id(value)
		local paid = value:find("%$") ~= nil and 1 or 0
		local status = is_staus(value)
		local title = is_title(value)
		local difficulty = is_difficulty(value)
		result[id] = { id = id, paid = paid, status = status, title = title, difficulty = difficulty }
		table.insert(result_tab, result[id])
		::continue::
	end
	return { result = result, result_tab = result_tab }
end

return M
