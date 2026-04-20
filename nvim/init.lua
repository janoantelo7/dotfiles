-- ==========================================================================
-- PLUGINS
-- ========================================================================== 

vim.pack.add({
	{src = "https://github.com/folke/tokyonight.nvim", name = "tokyonight" }
})

-- ==========================================================================
-- CONFIG
-- ========================================================================== 

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4

vim.cmd.colorscheme "tokyonight-storm"
