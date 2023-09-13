if vim.fn.exists('g:loaded_leetcode_nvim') == 1 then
  return
end

vim.g.loaded_leetcode_nvim = 1

vim.api.nvim_create_user_command("LeetcodeList", function ()
  require('leetcode.questions').tele_list()
end, {})

-- vim.api.nvim_create_user_command("LeetcodeSubmit", function ()
--   require('leetcode.runner').submit()
-- end, {})

vim.api.nvim_create_user_command("LeetcodeTest", function ()
  require('leetcode.runner').test()
end, {})


vim.api.nvim_create_user_command("LeetcodeSubmit", function ()
  require('leetcode.runner').submit()
end, {})
