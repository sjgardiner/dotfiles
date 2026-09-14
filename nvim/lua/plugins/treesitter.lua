return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = "VeryLazy",
    lazy = vim.fn.argc(-1) == 0,
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'vimdoc', 'c', 'cpp', 'lua', 'python', 'diff',
          'regex', 'yaml', 'json', 'vim', 'bibtex', 'cmake',
          'fortran', 'javascript', 'bash', 'doxygen', 'latex',
          'make', 'rst', 'ssh_config'
        },
        sync_install = true,
        indent = {
          enable = true,
        },
        highlight = {
          enable = true,
        },
      })
    end,
  },
}
