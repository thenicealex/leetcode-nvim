local M = {}

M.reload = function()
  for k in pairs(package.loaded) do
    if k:match("^leetcode") then
      package.loaded[k] = nil
    end
  end
end

return M
