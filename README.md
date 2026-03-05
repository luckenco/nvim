# Neovim Configuration

My personal Neovim configuration using lazy.nvim for plugin management.

## Features

- Native Neovim 0.11+ LSP setup with autocompletion
- Nix-managed language servers and tooling
- Treesitter for syntax highlighting
- Telescope for fuzzy finding
- Gitsigns for inline git hunk workflows
- mini.nvim modules for comment + surround editing
- Harpoon for quick navigation
- Spell checking is intentionally disabled by default to avoid false positives on technical terms (`:setlocal spell` to enable per buffer, `:setlocal nospell` to disable).

## Structure

- `init.lua` - Main entry point
- `lua/cal/` - Core configuration
  - `autocmds.lua` - Autocommands
  - `lazy_init.lua` - Plugin manager setup
  - `options.lua` - Neovim options
  - `remap.lua` - Key mappings
  - `usercmds.lua` - User commands
  - `plugins/` - Plugin configurations
    - `autoformat.lua` - Automatic code formatting
    - `colors.lua` - Color scheme configuration
    - `completion.lua` - Autocompletion settings
    - `gitsigns.lua` - Git hunk signs and actions
    - `harpoon.lua` - Quick file navigation
    - `lsp.lua` - Native 0.11+ Language Server configuration
    - `lsp_signature.lua` - Function signature help
    - `lualine.lua` - Status line customization
    - `mini.lua` - mini.nvim modules (comment/surround)
    - `rust_owl.lua` - Visualize ownership and lifetimes in Rust for debugging and optimization
    - `telescope.lua` - Fuzzy finder configuration
    - `treesitter.lua` - Syntax highlighting
- `after/` - Additional configuration
  - `ftplugin/` - Filetype-specific settings
  - `plugin/` - Post-plugin loading configuration
