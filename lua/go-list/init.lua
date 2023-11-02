local pickers = require("go-list.pickers")
local cli = require("go-list.cli")

local function find_files()
  local cwd = vim.fn.getcwd()
  local found = cli.list_files(cwd)

  pickers.show_file_picker("Find Go Files", found)
end

local function find_test_files()
  local cwd = vim.fn.getcwd()
  local found = cli.list_test_files(cwd)

  pickers.show_file_picker("Find Go Test Files", found)
end

return {
  find_files = find_files,
  find_test_files = find_test_files,
}
