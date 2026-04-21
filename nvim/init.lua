-- ==========================================================================
-- PLUGINS
-- ========================================================================== 

vim.pack.add({
    {src = "https://github.com/folke/tokyonight.nvim", name = "tokyonight" },
    {src = "https://github.com/neovim/nvim-lspconfig" }, -- Language Server
    -- Completion engine and sources
    {src = "https://github.com/hrsh7th/nvim-cmp" },
    {src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    {src = "https://github.com/hrsh7th/cmp-buffer" },
    {src = "https://github.com/hrsh7th/cmp-path" }

})

-- ==========================================================================
-- LSP & COMPLETION CONFIG
-- ========================================================================== 

local cmp = require('cmp')

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Go backward in documentation (ctrl + b)
        ['<C-f>'] = cmp.mapping.scroll_docs(4), -- Go Forward in documentation (ctrl + f)
        ['<C-Space>'] = cmp.mapping.complete(), -- Show suggestions menu if it's clossed in insert mode (ctrl + space)
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Only accept word if I selected one option with 'Enter' key
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' }, -- Language Server suggestions
        { name = 'path' }, -- File system paths
        { name = 'buffer' }, -- Text from current file
    })
})

-- Bridge between nvim-cmp and LSP capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('basedpyright', {
    capabilities = capabilities,
    settings = {
	python = {
	    pythonPath = ".venv/bin/python",
	}
    }
})

-- Setup ruff
vim.lsp.config('ruff', {
    capabilities = capabilities
})

-- Enable both servers globally for the current session
vim.lsp.enable({'basedpyright', 'ruff' })

-- Auto-format Python files on save with ruff 
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.py",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

-- ==========================================================================
-- CONFIG
-- ========================================================================== 

vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative numbers for easier jumping
vim.opt.shiftwidth = 4 -- Number of spaces for indentation

-- Apply the color theme
vim.cmd.colorscheme "tokyonight-storm"
