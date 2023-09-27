local M = {}

M.default_config = {
	domin = "cn",
	language = "cpp",
	directory = "/.leetcode",
  icons = {
    paid = "$", -- 👑
    aced = "✔ ",
		-- aced = "🚩",
    tried = "✘",
    starred = "★",
    locked = "🔒",
  }
}

M.config = {}

return M
