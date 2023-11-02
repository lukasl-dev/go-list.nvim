local ts_pickers = require("telescope.pickers")
local ts_finders = require("telescope.finders")
local ts_conf = require('telescope.config').values
local ts_action_state = require('telescope.actions.state')
local ts_actions = require('telescope.actions')

local utils = require("go-list.utils")

local function show_file_picker(title, abs_paths, open)
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
        open(selection.path)
      end)
      return true
    end,
  }):find()
end

local function show_test_picker(title, tests_per_file, open)
  local tests = {}
  for file, test_names in pairs(tests_per_file) do
    for _, test_name in ipairs(test_names) do
      table.insert(tests, {test_name = test_name, file = file})
    end
  end

  ts_pickers.new({}, {
    prompt_title = title,
    finder = ts_finders.new_table {
      results = tests,
      entry_maker = function(entry)
        return {
          value = entry.test_name,
          display = entry.test_name,
          ordinal = entry.test_name,
          path = entry.file,
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
        open(selection.path)
      end)
      return true
    end,
  }):find()
end

return {
  show_file_picker = show_file_picker,
  show_test_picker = show_test_picker,
}
