local function os_path_delimiter()
  return vim.loop.os_uname().version:find("Windows") and "\\" or "/"
end

local function get_relative_path(absolute_path)
  return vim.fn.fnamemodify(absolute_path, ':.')
end

return {
  os_path_delimiter = os_path_delimiter,
  get_relative_path = get_relative_path,
}
