-- lua/plugins/quarto.lua
return {
  {
    'quarto-dev/quarto-nvim',
    ft = { 'quarto', 'markdown' }, -- .qmd is usually filetype "quarto"
    dependencies = {
      'jmbuhr/otter.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      local quarto = require 'quarto'
      quarto.setup {
        debug = false,
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          chunks = 'curly',
          languages = { 'r', 'python', 'julia', 'bash', 'html' },
          diagnostics = {
            enabled = true,
            triggers = { 'BufWritePost' },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          enabled = true,
          default_method = 'molten', -- "molten", "slime", "iron" or a function
          ft_runners = {},
          never_run = { 'yaml' },
        },
      }

      -- Preview
      vim.keymap.set('n', '<leader>qp', quarto.quartoPreview, { desc = 'Quarto Preview', silent = true })
      vim.keymap.set('n', '<leader>qP', quarto.quartoClosePreview, { desc = 'Quarto Close Preview', silent = true })

      -- Run mappings (requires a configured code runner plugin, e.g. vim-slime/molten/iron)
      local runner = require 'quarto.runner'
      vim.keymap.set('n', '<localleader>rc', runner.run_cell, { desc = 'Run cell', silent = true })
      vim.keymap.set('n', '<localleader>ra', runner.run_above, { desc = 'Run cell + above', silent = true })
      vim.keymap.set('n', '<localleader>rA', runner.run_all, { desc = 'Run all (same lang)', silent = true })
      vim.keymap.set('n', '<localleader>rl', runner.run_line, { desc = 'Run line', silent = true })
      vim.keymap.set('v', '<localleader>r', runner.run_range, { desc = 'Run visual range', silent = true })
      vim.keymap.set('n', '<localleader>RA', function()
        runner.run_all(true)
      end, { desc = 'Run all (all langs)', silent = true })
    end,
  },
}
