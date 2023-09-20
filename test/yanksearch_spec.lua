local ysearch = require('yanksearch')
local function stringToAscii(str)
  local ascii = {}
  for i = 1, #str do
    table.insert(ascii, string.byte(str, i))
  end
  return table.concat(ascii, " ")
end

describe('YankSearch Plugin', function()
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
  describe('yank_matching_lines function with config', function()
    local function setup_buffer_and_search(pattern)
      -- Populate buffer with sample lines
      vim.api.nvim_buf_set_lines(0, 0, -1, false, {
        "This is line 1",
        "This is line 2",
        "This is line 3",
        "This is line 4",
        "This is line 5",
      })
      vim.fn.setreg('/', pattern)
    end

    local test_cases = {
      {
        config = { lines_above = 0, lines_below = 0, lines_around = 0 },
        expected = "This is line 3\n",
      },
      {
        config = { lines_above = 1, lines_below = 0, lines_around = 0 },
        expected = "This is line 2\nThis is line 3\n",
      },
      -- Add more test cases here
    }

    for _, test_case in ipairs(test_cases) do
      it("should yank correctly with given config", function()
        -- Setup
        setup_buffer_and_search("line 3")
        ysearch.config = test_case.config

        -- Exercise
        ysearch.yank_matching_lines()

        -- Verify
        local yanked_text = vim.fn.getreg('+') .. '\n' -- Append a newline
        assert.is_true(yanked_text == test_case.expected)


        -- Teardown
        -- Clear buffer and reset settings if needed
        vim.api.nvim_buf_set_lines(0, 0, -1, false, {})
      end)
    end
  end)



  describe("YankSearch Plugin yank_matching_lines function with complex scenarios", function()
    local function setup_buffer_and_search(pattern, buffer)
      -- Populate buffer with sample lines
      vim.api.nvim_buf_set_lines(0, 0, -1, false, buffer)
      vim.fn.setreg('/', pattern)
    end

    local complex_buffer = {
      "This is line 1",
      "This is line 2 with pattern",
      "This is line 3",
      "This is line 4 with pattern",
      "This is line 5",
      "This is line 6 with pattern",
      "This is line 7",
      "This is line 8 with pattern",
      "This is line 9",
      "This is line 10",
    }

    local complex_test_cases = {
      {
        config = { lines_above = 0, lines_below = 0, lines_around = 0 },
        expected = "This is line 3\n",
      },
      {
        config = { lines_above = 1, lines_below = 0, lines_around = 0 },
        expected = "This is line 2 with pattern\nThis is line 3\n",
      },
      -- Add more test cases here
    }

    for _, test_case in ipairs(complex_test_cases) do
      it("should yank correctly with given config", function()
        -- Setup
        setup_buffer_and_search("line 3", complex_buffer) -- Pass the complex_buffer here
        ysearch.config = test_case.config

        -- Exercise
        ysearch.yank_matching_lines()

        -- Verify
        local yanked_text = vim.fn.getreg('+') .. '\n' -- Append a newline
        print("Yanked Text ASCII: ", stringToAscii(yanked_text))
        print("Expected Text ASCII: ", stringToAscii(test_case.expected))
        assert.is_true(yanked_text == test_case.expected)

        -- Teardown
        -- Clear buffer and reset settings if needed
        vim.api.nvim_buf_set_lines(0, 0, -1, false, {})
      end)
    end
  end)
end)
