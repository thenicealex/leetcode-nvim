local M = {}
M.difficulty = nil
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
-- local themes = require("telescope.themes")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

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


local function filter_problems()
	local problems
	if M.difficulty == "EASY" then
		problems = vim.fn.systemlist("leetcode list -q e")
  elseif M.difficulty == "MEDIUM" then
		problems = vim.fn.systemlist("leetcode list -q m")
  elseif M.difficulty == "HARD" then
		problems = vim.fn.systemlist("leetcode list -q h")
	else
		problems = vim.fn.systemlist("leetcode list")
	end
	if problems == nil then
		return { result = {}, result_tab = { { "nil", "nil", "nil", "nil", "nil" } } }
	end
	local result = {}
	local result_tab = {}
	for _, value in pairs(problems) do
		if value:find("Warning") or value:find("warning") then
			goto continue
		end
		local id = value:match("%[(.-)%]")
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

function M.list()
	local question_all = filter_problems().result_str
	vim.cmd("vsplit")
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_win_set_buf(win, buf)
	for _, value in pairs(question_all) do
		vim.api.nvim_buf_set_lines(buf, -1, -1, true, { value })
	end
end

local function update_status(entry)
	local statuses = {
		ac = "🚩",
		notac = "❌",
		AC = "🚩",
		TRIED = "❌",
	}
	local sts = entry.value.status
	if sts == "ac" then
		return statuses.ac
	elseif sts == "tried" then
		return statuses.TRIED
	else
		return " "
	end
end

local function update_paid(entry)
	local paid = entry.value.paid
	if paid == 1 then
		return "👑"
	else
		return " "
	end
end

local function gen_from_questions()
	local entry_display = require("telescope.pickers.entry_display")
	local make_entry = require("telescope.make_entry")
	local displayer = entry_display.create({
		separator = "",
		items = {
			{ width = 10 },
			{ width = 4 },
			{ width = 4 },
			{ width = 45 },
			{ width = 8 },
		},
	})

	local make_display = function(entry)
		return displayer({
			{ entry.value.id, "Number" },
			{ update_paid(entry), "Number" },
			{ update_status(entry), "Number" },
			{ entry.value.title, "Title" },
			{ entry.value.difficulty, "Number" },
		})
	end

	return function(o)
		local entry = {
			display = make_display,
			value = {
				id = o.id,
				paid = o.paid,
				status = o.status,
				title = o.title,
				difficulty = o.difficulty,
			},
			ordinal = string.format("%s %s%s %s %s", o.id, o.paid, o.status, o.title, o.difficulty),
		}
		return make_entry.set_default_entry_mt(entry, {})
	end
end

local function select_problem(prompt_bufnr)
	actions.close(prompt_bufnr)
	local problem = action_state.get_selected_entry()
	local que_title = problem["value"]["title"]
	local output = vim.fn.systemlist("leetcode show -gx " .. que_title .. " -l cpp -o C:/Users/liran/.leetcode/")
	if output == nil then
		return
	end
	local file_name
	for _, value in pairs(output) do
		if value:match("Source Code:") then
			file_name = value
		end
	end
	file_name = file_name:match("Source Code:%s+(.+)")
	print(file_name)
	vim.api.nvim_command("edit " .. file_name)
end

function M.tele_list()
	local que_list = function(opts)
		opts = opts or {}
		pickers
			.new(opts, {
				prompt_title = "Problems",
				finder = finders.new_table({
					results = filter_problems().result_tab,
					entry_maker = gen_from_questions(),
				}),
				previewer = false,
				sorter = conf.generic_sorter(opts),
				attach_mappings = function(_, map)
					map({ "n", "i" }, "<CR>", select_problem)
					map({ "n", "i" }, "<A-e>", function()
						M.difficulty = "EASY"
						M.tele_list()
					end)
					map({ "n", "i" }, "<A-m>", function()
						M.difficulty = "MEDIUM"
						M.tele_list()
					end)
					map({ "n", "i" }, "<A-h>", function()
						M.difficulty = "HARD"
						M.tele_list()
					end)
					return true
				end,
			})
			:find()
	end

	que_list()
end

return M
