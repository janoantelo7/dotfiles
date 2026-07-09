# Jano's Dotfiles

A lightweight, modern, and highly efficient developer environment configuration.

These dotfiles are tailored for modern development workflows, utilizing state-of-the-art tools and built-in features to maintain a clean, minimal, and blazing-fast developer environment.

---

## Repository Structure

- `setup.sh`: Installation script to automatically set up configurations and back up conflicting files.
- `.config/`:
  - `nvim/`: Neovim configuration files.
    - `init.lua`: The central configuration hub containing settings, package declarations, LSP setups, keybindings, and UI configurations.
    - `nvim-pack-lock.json`: Lockfile for Neovim's native package manager (`vim.pack`), ensuring reproducible plugin installations across systems.

---

## Prerequisites & Setup

Ensure the following tools are installed on your system:

1. **Neovim 0.12+** (Requires built-in package management support via `vim.pack`)
2. **uv** (The extremely fast Python package and tool installer)
3. **Language Servers** (Installed globally using `uv`):
   ```bash
   uv tool install basedpyright
   uv tool install ruff
   ```

### Installation

To deploy the configurations, run the setup script from the root of this repository:

```bash
chmod +x setup.sh
./setup.sh
```

This script will automatically create the necessary directories (e.g., `~/.config`), back up any conflicting existing configurations, and create symlinks to the repository files.

Upon launching Neovim, the built-in package manager will resolve and install the plugins locked in `nvim-pack-lock.json`.

---

## Neovim Features & Configuration

The Neovim environment is modularly organized and designed for responsiveness:

### Package Management
Leverages **Neovim's native pack system** (`vim.pack.add`) rather than third-party package managers. Dependencies are defined directly in Lua and locked in `nvim-pack-lock.json` for deterministic setups.

### Python IDE Integration
- **LSP Config**: Integrated with `basedpyright` (configured for `"standard"` type checking and dynamically resolved virtualenvs in `.venv`) and `ruff` for ultra-fast linting and code diagnostics.
- **Auto-Formatting**: Configured to run `ruff` formatting automatically on save (`BufWritePre` for `*.py` files).
- **Autocomplete**: Driven by `nvim-cmp` with completions populated from LSP diagnostics, buffer context, and system paths.

### Visuals & UI
- **Theme**: [Dracula](https://github.com/mofiqul/dracula.nvim) colorscheme with termguicolors enabled.
- **Status Line**: [Lualine](https://github.com/nvim-lualine/lualine.nvim) for a fast, clean, and highly readable status display.
- **Bufferline**: [Bufferline.nvim](https://github.com/akinsho/bufferline.nvim) for modern tab-like buffer switching.
- **File Explorer**: [Neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) for smooth, sidebar-style project exploration.

---

## Keybindings & Shortcuts

This configuration maps logical shortcuts for fast navigation:

### File Explorer & Window Focus
| Shortcut | Action | Mode | Description |
| :--- | :--- | :---: | :--- |
| `<Ctrl-n>` | Toggle File Explorer | Normal | Open/Close Neo-tree sidebar |
| `<Ctrl-h>` | Focus File Explorer | Normal | Move cursor focus to the Neo-tree sidebar |
| `<Ctrl-l>` | Focus Editor | Normal | Move cursor focus back to the code editor |

### Buffer Navigation
| Shortcut | Action | Mode | Description |
| :--- | :--- | :---: | :--- |
| `<Tab>` | Next Buffer | Normal | Switch to the next open buffer |
| `<Shift-Tab>` | Previous Buffer | Normal | Switch to the previous open buffer |

### Autocomplete Suggestion Menu
| Shortcut | Action | Mode | Description |
| :--- | :--- | :---: | :--- |
| `<Ctrl-Space>` | Open Autocomplete | Insert | Trigger the autocomplete popup manually |
| `<Enter>` / `<CR>` | Confirm Selection | Insert | Confirm and insert the *selected* suggestion |
| `<Ctrl-f>` | Scroll Documentation Down | Insert | Scroll down in the documentation window |
| `<Ctrl-b>` | Scroll Documentation Up | Insert | Scroll up in the documentation window |

---

## Core Vim Settings

- Line numbers and **relative line numbers** are enabled for rapid code jumping (`j`/`k` movements).
- Default indentation is set to **4 spaces** (`shiftwidth = 4`).

