local M = {}

M.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1


function M.check()
  if not vim.fn.executable("leetcode") then
    print("leetcode-cli not exits!")
    return
  end
end

return M
