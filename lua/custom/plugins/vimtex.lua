return {
  'lervag/vimtex',
  config = function()
    -- Set your preferred PDF viewer (e.g., zathura, skim, okular)
    vim.g.vimtex_view_method = 'zathura'
    -- Use latexmk as the compiler backend (default, works well)
    vim.g.vimtex_compiler_method = 'latexmk'
    -- Optional: use 'tectonic' instead of 'latexmk'
    -- vim.g.vimtex_compiler_method = 'tectonic'
  end,
}
