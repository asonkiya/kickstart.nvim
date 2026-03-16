-- lua/plugins/molten.lua
return {
  {
    'benlubas/molten-nvim',
    build = ':UpdateRemotePlugins',
    ft = { 'quarto', 'markdown' },
    cmd = {
      'MoltenInit',
      'MoltenEvaluateLine',
      'MoltenEvaluateRange',
      'MoltenEvaluateOperator',
      'MoltenRestart',
      'MoltenInterrupt',
      'MoltenDelete',
      'MoltenHideOutput',
      'MoltenShowOutput',
    },
    init = function()
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
  },
}
