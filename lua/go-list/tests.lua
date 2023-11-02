local files = require("go-list.files")

local function list_tests(dir)
  local test_files = files.list_test_files(dir)

  local tests_per_file = {}
  for _, test_file in ipairs(test_files) do
    local file_content = vim.fn.system("cat " .. test_file)

    local matches = {}
    for match in file_content:gmatch("func%s+(Test[%w_]+)%s*%b()") do
      table.insert(matches, match)
    end
    tests_per_file[test_file] = matches
  end

  return tests_per_file
end

return {
  list_tests = list_tests,
}
