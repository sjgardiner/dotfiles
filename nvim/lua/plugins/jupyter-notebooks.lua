return {

  {
    "sjgardiner/jupytext.nvim",
    config = true,
    -- Depending on your nvim distro or config you may need to make the loading
    -- not lazy
    lazy = false,
  },

  {
    "sjgardiner/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- This is an example, not a default.
      -- Please see the readme for more configuration options
      vim.g.molten_output_win_max_height = 12
      vim.g.molten_image_provider = "image.nvim"
    end,
    keys = {
      { "<localleader>mi", "<cmd>MoltenInit<cr>",
        silent = true, desc = "initialize the plugin" },
      { "<localleader>mI", "<cmd>MoltenInfo<cr>",
        silent = true, desc = "show info" },
      { "<localleader>mn", "<cmd>MoltenNext<cr>",
        silent = true, desc = "goto next cell" },
      { "<localleader>mp", "<cmd>MoltenPrev<cr>",
        silent = true, desc = "goto previous cell" },
      { "<localleader>e", "<cmd>MoltenEvaluateOperator<cr>",
        silent = true, desc = "run operator selection" },
      { "<localleader>rl", "<cmd>MoltenEvaluateLine<cr>",
        silent = true, desc = "evaluate line" },
      { "<localleader>rr", "<cmd>MoltenReevaluateCell<cr>",
        silent = true, desc = "re-evaluate cell" },
      { "<localleader>r", ":<C-u>MoltenEvaluateVisual<cr>gv",
        silent = true, mode="v", desc = "evaluate visual selection" },
      { "<localleader>rD", "<cmd>MoltenDelete<CR>",
        silent = true, desc = "delete cell" },
      { "<localleader>oh", ":MoltenHideOutput<CR>",
        silent = true, desc = "hide output" },
      { "<localleader>os", ":noautocmd MoltenEnterOutput<CR>",
        silent = true, desc = "show/enter output" },
    },
  },

  {
    "GCBallesteros/NotebookNavigator.nvim",
    keys = {
      { "]h", function() require("notebook-navigator").move_cell "d" end },
      { "[h", function() require("notebook-navigator").move_cell "u" end },
      { "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
      { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
    },
    dependencies = {
      "echasnovski/mini.comment",
      "sjgardiner/molten-nvim", -- repl provider
      --"hkupty/iron.nvim", -- alternative repl provider
      -- "akinsho/toggleterm.nvim", -- alternative repl provider
      --"anuvyklack/hydra.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("notebook-navigator").setup({})
    end,
  },
}
