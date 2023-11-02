local ts_pickers = require("telescope.pickers")
local ts_finders = require("telescope.finders")
local ts_conf = require('telescope.config').values
local ts_action_state = require('telescope.actions.state')
local ts_actions = require('telescope.actions')

local utils = require("go-list.utils")

local function show_file_picker(title, abs_paths)
  ts_pickers.new({}, {
    prompt_title = title,
    finder = ts_finders.new_table {
      results = abs_paths,
      entry_maker = function(entry)
        return {
          value = entry,
          display = utils.get_relative_path(entry),
          ordinal = utils.get_relative_path(entry),
          path = entry,
        }
      end,
    },
    sorter = ts_conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, _)
      ts_actions.select_default:replace(function()
        local selection = ts_action_state.get_selected_entry()
        if selection == nil then
          return
        end
        ts_actions.close(prompt_bufnr)
        vim.cmd('edit ' .. selection.path)
      end)
      return true
    end,
  }):find()
end

return {
  show_file_picker = show_file_picker,
}
