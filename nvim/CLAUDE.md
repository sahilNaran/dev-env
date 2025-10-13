# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration written in Lua, using the lazy.nvim plugin manager. The configuration is optimized for TypeScript/JavaScript, Go, Dart/Flutter, Elixir, C++, Swift, and Lua development.

## Architecture

### Module Structure

- **Entry point**: `init.lua` loads `lua/sahil/init.lua`
- **Core modules** (in `lua/sahil/`):
  - `set.lua`: Editor settings (2-space tabs, relative line numbers, etc.)
  - `remap.lua`: Custom keymaps (leader key is `<Space>`)
  - `lazy_init.lua`: Bootstraps lazy.nvim plugin manager
  - `lsp_toggle.lua`: TypeScript LSP server switcher module
- **Plugin specs**: `lua/sahil/plugins/*.lua` (auto-loaded by lazy.nvim)

### TypeScript LSP Server Toggle System

The configuration supports switching between two TypeScript LSP servers:
- **ts_ls** (standard): Default TypeScript language server
- **tsgo**: Experimental TypeScript-Go language server

Implementation split across:
- `lua/sahil/lsp_toggle.lua`: Core toggle logic, state management, commands (`:TSServerCheck`, `:ToggleTSServer`)
- `lua/sahil/plugins/lsp.lua`: LSP setup logic that conditionally uses tsgo based on toggle state
- `lua/sahil/remap.lua`: Keybinding `<leader>ts` to toggle servers

### Plugin System

Uses lazy.nvim with plugin specifications in `lua/sahil/plugins/`. Key plugins:
- **LSP**: mason.nvim + nvim-lspconfig (supports Lua, TypeScript, Go, Elixir, C++, Dart, Swift, Templ, Tailwind, JSON)
- **Formatting**: conform.nvim with format-on-save
- **Completion**: nvim-cmp with LSP, LuaSnip, buffer sources
- **Navigation**: Telescope (fuzzy finding), Harpoon (file marks), nvim-tree (file explorer)
- **Utilities**: which-key, lazygit, trouble, flash, treesitter

## Development Commands

### Swift Development Setup

For iOS/macOS Swift development, install the Swift toolchain:

```bash
# Install Xcode from App Store (includes Swift)
# Or install Swift toolchain directly from swift.org

# Verify installation
swift --version
sourcekit-lsp --help

# Install swift-format for code formatting
brew install swift-format
```

The configuration uses:
- **sourcekit-lsp**: Language server (bundled with Swift toolchain)
- **swift-format**: Code formatter (install via Homebrew)

### TypeScript-Go LSP Setup

If using the tsgo LSP server, install it first:

```bash
# Install dependencies
brew install go node

# Clone and build typescript-go
git clone --recurse-submodules https://github.com/microsoft/typescript-go.git
cd typescript-go
npm ci
npx hereby build

# Add to PATH
echo 'export PATH="$PATH:'$(pwd)'/built/local/"' >> ~/.zshrc
```

Update typescript-go:
```bash
cd typescript-go
git pull
git submodule update --recursive
npx hereby build
```

### Neovim Commands

- `:Lazy`: Open lazy.nvim plugin manager UI (install, update, clean plugins)
- `:Mason`: Open Mason LSP installer UI
- `:LspInfo`: Show active LSP clients for current buffer
- `:TSServerCheck`: Check which TypeScript LSP server is active
- `:ToggleTSServer`: Switch between ts_ls and tsgo (or use `<leader>ts`)
- `:LspRestart`: Restart LSP server for current buffer

### File Editing Workflow

Key file navigation patterns:
- Use Telescope (`<leader>ff`, `<leader>fs`) for project-wide file/text search
- Use Harpoon (`<leader>a` to mark, `<leader>1-4` to jump) for frequently accessed files
- Use nvim-tree (`<leader>ee`) for directory browsing

## Important Configuration Details

### Formatting

Auto-formatting on save is enabled via conform.nvim in `lua/sahil/plugins/formatting.lua`. Formatters by filetype:
- TypeScript/JavaScript: prettier
- Lua: stylua
- Elixir: mix
- C++: clang_format
- Dart: dart_format
- Swift: swift_format

Manual format: `<leader>mp`

### LSP Configuration

LSP settings in `lua/sahil/plugins/lsp.lua`:
- Auto-installed servers via Mason: lua_ls, ts_ls, elixirls, clangd, tailwindcss, jsonls, gopls, templ
- Dart LSP configured separately (dartls, dcmls) with custom SDK paths
- Swift LSP (sourcekit-lsp) configured for Swift/Objective-C development (bundled with Xcode, not installed via Mason)
- Custom Lua LSP config recognizes vim global and test globals

Common LSP keybindings (available when LSP attaches):
- `gd`: Go to definition (Telescope)
- `gR`: Show references (Telescope)
- `K`: Hover documentation
- `<leader>ca`: Code actions
- `<leader>rn`: Rename symbol
- `[d` / `]d`: Navigate diagnostics

### Editor Settings

From `lua/sahil/set.lua`:
- 2-space indentation (soft tabs)
- Relative line numbers
- No line wrapping
- System clipboard integration
- `.cc` files treated as C++

### Custom Keybindings

Leader key: `<Space>` (see `lua/sahil/remap.lua` for full list)

Core navigation:
- `<C-h/j/k/l>`: Tmux-aware window navigation
- `<C-e>`: Harpoon quick menu
- `<leader>ee`: Toggle file tree

## Troubleshooting

### TypeScript LSP Issues

1. Check active server: `:TSServerCheck`
2. Verify LSP is running: `:LspInfo`
3. Toggle to other server: `<leader>ts` or `:ToggleTSServer`
4. Restart LSP: `:LspRestart`

### Plugin Installation

If plugins fail to load, open lazy.nvim UI (`:Lazy`) and install/update manually.
