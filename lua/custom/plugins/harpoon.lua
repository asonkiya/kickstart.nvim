return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },

  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {}

    -- Telescope UI for Harpoon
    local conf = require('telescope.config').values

    local function toggle_telescope(harpoon_files)
      local function make_finder()
        local paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(paths, item.value)
        end

        return require('telescope.finders').new_table {
          results = paths,
        }
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = make_finder(),
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
          attach_mappings = function(prompt_bufnr, map)
            local state = require 'telescope.actions.state'

            local function refresh()
              local picker = state.get_current_picker(prompt_bufnr)
              if picker then
                picker:refresh(make_finder(), { reset_prompt = false })
              end
            end

            local function delete_selected()
              local entry = state.get_selected_entry()
              if not entry then
                return
              end
              if not entry.value then
                return
              end

              -- remove by value (stable even if entry.index is weird)
              for idx, item in ipairs(harpoon_files.items) do
                if item.value == entry.value then
                  table.remove(harpoon_files.items, idx)
                  break
                end
              end

              refresh()
            end

            local function move_selected(delta)
              local entry = state.get_selected_entry()
              if not entry then
                return
              end
              if not entry.value then
                return
              end

              -- find the selected item by value in harpoon list
              local i
              for idx, item in ipairs(harpoon_files.items) do
                if item.value == entry.value then
                  i = idx
                  break
                end
              end
              if not i then
                return
              end

              local j = i + delta
              if j < 1 or j > #harpoon_files.items then
                return
              end

              harpoon_files.items[i], harpoon_files.items[j] = harpoon_files.items[j], harpoon_files.items[i]

              refresh()
            end

            -- delete
            map('i', '<C-d>', delete_selected)
            map('n', '<C-d>', delete_selected)

            -- move up/down (no cursor management)
            map('i', '<C-k>', function()
              move_selected(1)
            end)
            map('n', '<C-k>', function()
              move_selected(1)
            end)
            map('i', '<C-j>', function()
              move_selected(-1)
            end)
            map('n', '<C-j>', function()
              move_selected(-1)
            end)

            return true
          end,
        })
        :find()
    end

    -- Keymaps
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon add file' })

    -- Open Harpoon via Telescope
    vim.keymap.set('n', '<C-e>', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Harpoon (Telescope)' })

    vim.keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end)
  end,
}
