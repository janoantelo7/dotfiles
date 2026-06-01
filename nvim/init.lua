-- ==========================================================================
-- PLUGINS
-- ========================================================================== 

vim.pack.add({
    {src = "https://github.com/mofiqul/dracula.nvim", name = "dracula" },
    {src = "https://github.com/neovim/nvim-lspconfig" }, -- Language Server
    -- Completion engine and sources
    {src = "https://github.com/hrsh7th/nvim-cmp" },
    {src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    {src = "https://github.com/hrsh7th/cmp-buffer" },
    {src = "https://github.com/hrsh7th/cmp-path" },
    {src = "https://github.com/nvim-lualine/lualine.nvim" },

    -- file explorer
    {src = "https://github.com/nvim-lua/plenary.nvim"},
    {src = "https://github.com/MunifTanjim/nui.nvim"},
    {src = "https://github.com/nvim-tree/nvim-web-devicons"},
    {src = "https://github.com/nvim-neo-tree/neo-tree.nvim"},
    {src = "https://github.com/akinsho/bufferline.nvim"}

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
	basedpyright = {
	    typeCheckingMode = "standard"
	},
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
-- STATUS BAR CONFIG
-- ========================================================================== 

require('lualine').setup({
    options = {
	theme = 'auto'
    }
})


-- ==========================================================================
-- FILE EXPLORER CONFIG
-- ========================================================================== 

require("neo-tree").setup({
    window = {
	position = "left",
	width = 30,
    },
    filesystem = {
	filtered_items = {
	    visible = true, -- Show hidden files
	},
	follow_current_file = {
	    enabled = true,  
	},
    }
})

-- Keyboard shortcuts
vim.keymap.set('n', '<C-n>', "<Cmd>Neotree toggle<CR>", { desc = "Alternate side bar" })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move the focus to left (neo-tree)" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move the focus to right (editor)" })

-- ==========================================================================
-- BUFFERLINE CONFIG
-- ========================================================================== 

vim.opt.termguicolors = true
require("bufferline").setup({
    options = {
        offsets = {
            {
                filetype = "neo-tree",
                text = "File Explorer",
                text_align = "center",
                separator = true,
            }
        }
    }
})

-- Bufferline keyboard shortcuts
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { desc = "Previous buffer" })

-- ==========================================================================
-- CONFIG
-- ========================================================================== 

vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative numbers for easier jumping
vim.opt.shiftwidth = 4 -- Number of spaces for indentation

-- Apply the color theme
vim.cmd.colorscheme "dracula"
