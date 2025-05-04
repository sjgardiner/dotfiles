return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        handlers = {
          function(server)
            require("lspconfig")[server].setup({})
          end,
        },
      })
    end,
    keys = {
      { "<leader>l", "", desc = "LSP" },
      { "<leader>lI", "<cmd>LspInfo<cr>", desc = "LSP Info" },
      { "<leader>li", vim.lsp.buf.implementation, desc = "Goto Implementation" },
      { "<leader>ld", vim.lsp.buf.definition, desc = "Goto Definition" },
      { "<leader>lD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "<leader>lo", vim.lsp.buf.type_definition, desc = "Goto Type Definition" },
      { "<leader>lK", vim.lsp.buf.hover, desc = "Hover" },
      { "<C-s>", vim.lsp.buf.signature_help, mode="i", desc = "Signature Help" },
      { "<leader>lr", vim.lsp.buf.references, desc = "References" },
      { "<leader>lR", vim.lsp.buf.rename, desc = "Rename" },
      { "<leader>lp", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
      { "<leader>ln", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
      { "<leader>le", vim.diagnostic.open_float, desc = "Show Error Messages" },
      { "<leader>lq", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "v" }},
      { "<leader>lh", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch to Header/Source" },
    },
  }
}
