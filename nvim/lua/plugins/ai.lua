return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      -- or zbirenbaum/copilot.lua
      { "github/copilot.vim" },
      -- for curl, log and async functions
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on
    -- them
  },
}
