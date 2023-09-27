local M = {}

M.debug = function(...)
    local date = os.date("%Y-%m-%d %H:%M:%S")
    local args = { ... }
    for _, value in pairs(args) do
        print(date, vim.inspect(value))
    end
end

M.reload = function()
  for k in pairs(package.loaded) do
    if k:match("^leetcode") then
      package.loaded[k] = nil
    end
  end
end

return M
