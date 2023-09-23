if vim.fn.exists('g:loaded_leetcode_nvim') == 1 then
  return
end

vim.g.loaded_leetcode_nvim = 1

vim.api.nvim_create_user_command("LCList", function ()
  require('leetcode.telescope').telescope_list_all()
end, {})

vim.api.nvim_create_user_command("LCTest", function ()
  require('leetcode.commands').test()
end, {})

vim.api.nvim_create_user_command("LCSubmit", function ()
  require('leetcode.commands').submit()
end, {})

vim.api.nvim_create_user_command("LCDisplay", function ()
  require('leetcode.display').toggle()
end, {})

-- vim.api.nvim_create_user_command("LCTEST", function ()
--   require('leetcode.questions').test()
-- end, {})
