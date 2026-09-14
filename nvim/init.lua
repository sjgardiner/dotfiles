vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.g.have_nerd_font = true

-- Sync clipboard between OS and neovim
vim.opt.clipboard = "unnamedplus"

-- Replace tabs with two spaces
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- Still use tabs for Makefiles
vim.cmd( [[autocmd FileType make set noexpandtab]] )

-- View substitutions live
vim.opt.inccommand = "split"

-- Reserve space for the sign column by default
vim.opt.signcolumn = 'yes'

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*", -- For all file types
  command = ":%s/\\s\\+$//e",
})

require("config.lazy")

require("image").enable()

vim.cmd.colorscheme "catppuccin-mocha"
