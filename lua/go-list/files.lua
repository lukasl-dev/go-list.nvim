local path_delimiter = require("go-list.utils").os_path_delimiter()

local function list_files_by_property(property, dir)
  local cmd = string.format(
    "go list -f \"{{range .%s}}{{$.Dir}}%s{{.}},{{end}}\" %s/...",
    property, path_delimiter, dir
  )
  local output = vim.fn.system(cmd):match("^%s*(.-)%s*$"):gsub("\n", ",")

  if vim.v.shell_error ~= 0 then
    return {}
  end

  local files = {}
  for _, file in ipairs(vim.fn.split(output, ",")) do
    if file ~= "" then
      table.insert(files, file)
    end
  end
  return files
end

local function list_files(dir)
  return list_files_by_property("GoFiles", dir)
end

local function list_test_files(dir)
  return list_files_by_property("TestGoFiles", dir)
end

return {
  list_files = list_files,
  list_test_files = list_test_files,
}
