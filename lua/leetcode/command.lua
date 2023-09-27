local api, fn = vim.api, vim.fn

local command_store = {}

-- get command keys
--- @return string[]
local function command_keys()
	return vim.tbl_keys(command_store)
end

-- exec run function
--- @param key string?
--- @param args any
local function exec(key, args)
	if key == nil then
		return
	else
		if command_store[key] then
			pcall(command_store[key].run, args)
		else
			local message = "string.format('command %s not exist!', key)"
			api.nvim_notify("[LeetCode]." .. message, vim.log.levels.WARN, {})
		end
	end
end

local M = {}

-- init for the command
M.init = function()
	api.nvim_create_user_command("LCode", function(args)
		exec(unpack(args.fargs))
	end, {
		range = true,
		nargs = "*",
		complete = function(_, cmdline, _)
			local cmd = fn.split(cmdline)
			local key_list = command_keys()

			if #cmd <= 1 then
				return key_list
			end

			local args = vim.tbl_get(command_store, cmd[2], "args")
			if not args then
				return {}
			end

			return args
		end,
	})
	M.setup()
end

M.setup = function()
	M.register_command("list", function()
		require("leetcode.telescope").telescope_list_all()
	end, {})
	M.register_command("test", function()
		require("leetcode.runner").test()
	end, {})
	M.register_command("submit", function()
		require("leetcode.runner").submit()
	end, {})
	-- M.register_command("display", function()
	-- 	require("leetcode.display").toggle()
	-- end, {})
end

-- this function register command
--- @param command_key string
--- @param run function
--- @param args string[]
M.register_command = function(command_key, run, args)
	command_store[command_key] = command_store[command_key] or {}
	command_store[command_key].run = run
	command_store[command_key].args = args
end
-- this function unregister command
--- @param command_key string
M.unregister_command = function(command_key)
	if command_store[command_key] then
		command_store[command_key] = nil
	end
end

return M
