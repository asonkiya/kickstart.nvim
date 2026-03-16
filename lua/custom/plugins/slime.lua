-- lua/plugins/slime.lua
return {
  {
    'jpalardy/vim-slime',
    ft = { 'quarto', 'markdown', 'rmd' }, -- load when editing .qmd/.md/.Rmd
    init = function()
      vim.g.slime_target = 'neovim'
      vim.g.slime_no_mappings = 1
      vim.g.slime_paste_file = vim.fn.stdpath 'cache' .. '/slime_paste'
      vim.g.slime_preserve_curpos = 1
    end,
    -- optional: make sure :SlimeConfig is available even before ft triggers
    cmd = { 'SlimeConfig' },
  },
}
