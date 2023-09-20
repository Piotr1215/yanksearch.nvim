if vim.g.yanksearch_version then
  return
end

vim.g.yanksearch_version = '0.0.1'

vim.api.nvim_create_user_command("YankMatchingLines", function()
  require("yanksearch").yank_matching_lines()
end, {})
