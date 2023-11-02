local pickers = require("go-list.pickers")
local files = require("go-list.files")
local tests = require("go-list.tests")

local function find_files()
  local cwd = vim.fn.getcwd()
  local found = files.list_files(cwd)

  pickers.show_file_picker("Find Go Files", found, function (path)
    vim.cmd('edit ' .. path)
  end)
end

local function find_test_files()
  local cwd = vim.fn.getcwd()
  local found = files.list_test_files(cwd)

  pickers.show_file_picker("Find Go Test Files", found, function (path)
    vim.cmd('edit ' .. path)
  end)
end

local function find_tests()
  local cwd = vim.fn.getcwd()
  local found = tests.list_tests(cwd)

  pickers.show_test_picker("Find Go Tests", found, function (path)
    vim.cmd('edit ' .. path)
  end)
end

return {
  find_files = find_files,
  find_test_files = find_test_files,
  find_tests = find_tests,
}
