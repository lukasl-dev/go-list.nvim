local function os_path_delimiter()
  return vim.loop.os_uname().version:find("Windows") and "\\" or "/"
end

local function get_relative_path(absolute_path)
  return vim.fn.fnamemodify(absolute_path, ':.')
end

local function get_parent_dir(absolute_path)
  local isDir = vim.fn.isdirectory(absolute_path) == 1
  if isDir and absolute_path:sub(-1) == '/' then
    absolute_path = absolute_path:sub(1, -2)
  end
  return vim.fn.fnamemodify(absolute_path, ":h")
end

return {
  os_path_delimiter = os_path_delimiter,
  get_relative_path = get_relative_path,
  get_parent_dir = get_parent_dir,
}
