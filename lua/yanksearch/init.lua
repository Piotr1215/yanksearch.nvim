local M = {}


function M.yank_matching_lines()
  local search_pattern = vim.fn.getreg('/')
  if search_pattern ~= '' then
    local matching_lines = {}
    for line_number = 1, vim.fn.line('$') do
      local line = vim.fn.getline(line_number)
      if vim.fn.match(line, search_pattern) ~= -1 then
        -- Add lines based on the user's configuration
        local start_line = math.max(1, line_number - M.config.lines_above)
        local end_line = math.min(vim.fn.line('$'), line_number + M.config.lines_below)

        for i = start_line, end_line do
          table.insert(matching_lines, vim.fn.getline(i))
        end

        -- If lines_around is set, override lines_above and lines_below
        if M.config.lines_around > 0 then
          start_line = math.max(1, line_number - M.config.lines_around)
          end_line = math.min(vim.fn.line('$'), line_number + M.config.lines_around)

          for i = start_line, end_line do
            table.insert(matching_lines, vim.fn.getline(i))
          end
        end
      end
    end

    if #matching_lines > 0 then
      local original_filetype = vim.bo.filetype
      vim.fn.setreg('+', table.concat(matching_lines, '\n'))
      vim.cmd('new')
      vim.cmd('0put +')
      vim.bo.filetype = original_filetype
    else
      print('No matches found')
    end
  end
end

M.config = {
  lines_above = 0,
  lines_below = 0,
  lines_around = 0,
}

function M.setup(user_config)
  M.config = vim.tbl_extend('force', M.config, user_config)
end

return M
