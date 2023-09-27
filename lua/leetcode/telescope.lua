local M = {}
local cfg = require("leetcode.config").config
local status = cfg.icons

local que = require("leetcode.questions")
local utils = require("leetcode.utils")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
-- local themes = require("telescope.themes")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function update_status(entry)
	local sts = entry.value.status
	if sts == "ac" then
		-- return statuses.ac
		return status.aced
	elseif sts == "tried" then
		return status.tried
	else
		return " "
	end
end

local function update_paid(entry)
	local paid = entry.value.paid
	if paid == 1 then
		return status.paid
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
	local que_id = problem["value"]["id"]
	local que_path = vim.loop.os_homedir()
	local output = vim.fn.systemlist("leetcode show -gx " .. que_id .. " -l ".. cfg.language .." -o " .. que_path .. cfg.directory)
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

function M.telescope_list_all()
	utils.check()
	local list_all = function(opts)
		opts = opts or {}
		pickers
			.new(opts, {
				prompt_title = "Problems",
				finder = finders.new_dynamic({
					fn = function()
            return que.filter_problems().result_tab
          end,
					entry_maker = gen_from_questions(),
				}),
				previewer = false,
				sorter = conf.generic_sorter(opts),
				attach_mappings = function(_, map)
					map({ "n", "i" }, "<CR>", select_problem)
					return true
				end,
			})
			:find()
	end

	list_all()
end

return M
