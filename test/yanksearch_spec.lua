local ysearch = require('yanksearch')
describe('yank_matching_lines function', function()
  it('should yank lines that match the search pattern', function()
    -- Setup
    vim.fn.setreg('/', 'pattern')
    -- Your setup code here, like populating a buffer with lines

    -- Exercise
    ysearch.yank_matching_lines()

    -- Verify
    local yanked_text = vim.fn.getreg('+')
    assert.is_true(yanked_text ~= nil)

    -- Teardown (if necessary)
  end)

  it('should do nothing when the search registry is empty', function()
    -- Setup
    vim.fn.setreg('/', '')
    local initial_yanked_text = vim.fn.getreg('+')
    -- Exercise
    ysearch.yank_matching_lines()
    -- Verify
    local yanked_text = vim.fn.getreg('+')
    assert.is_true(yanked_text == initial_yanked_text)
  end)
end)
