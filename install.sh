#!/bin/bash

# Cross-platform dev-env installer for Mac and Linux
# Sets up neovim and tmux configurations via symlinks

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo -e "${GREEN}Dev Environment Installer${NC}"
echo "======================================"

# Detect OS
OS="$(uname -s)"
case "$OS" in
    Darwin)
        echo "Detected OS: macOS"
        ;;
    Linux)
        echo "Detected OS: Linux"
        ;;
    *)
        echo -e "${RED}Unsupported OS: $OS${NC}"
        exit 1
        ;;
esac
echo ""

# Function to create symlink safely
create_symlink() {
    local source="$1"
    local target="$2"
    local name="$3"

    echo -n "Setting up $name... "

    # Check if target already exists
    if [ -L "$target" ]; then
        # It's a symlink - check if it points to the right place
        current_target="$(readlink "$target")"
        if [ "$current_target" = "$source" ]; then
            echo -e "${GREEN}already linked correctly${NC}"
            return 0
        else
            echo -e "${YELLOW}existing symlink found (points to $current_target)${NC}"
            read -p "  Remove and relink? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                rm "$target"
            else
                echo "  Skipped"
                return 1
            fi
        fi
    elif [ -e "$target" ]; then
        # It exists but is not a symlink - back it up
        backup_path="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}existing config found${NC}"
        echo "  Backing up to: $backup_path"
        mv "$target" "$backup_path"
    fi

    # Create the symlink
    ln -s "$source" "$target"
    echo -e "${GREEN}linked successfully${NC}"
}

# Setup nvim
echo "Neovim Configuration"
echo "--------------------"
create_symlink "$SCRIPT_DIR/nvim" "$CONFIG_DIR/nvim" "nvim"
echo ""

# Setup tmux
echo "Tmux Configuration"
echo "--------------------"
create_symlink "$SCRIPT_DIR/tmux" "$CONFIG_DIR/tmux" "tmux"
echo ""

# Install TPM (Tmux Plugin Manager) if not present
echo "Tmux Plugin Manager (TPM)"
echo "-------------------------"
TPM_DIR="$CONFIG_DIR/tmux/plugins/tpm"
if [ -d "$TPM_DIR" ]; then
    echo -e "${GREEN}TPM already installed${NC}"
else
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    echo -e "${GREEN}TPM installed${NC}"
    echo -e "${YELLOW}Note: Launch tmux and press prefix + I (Ctrl-Space + Shift-I) to install plugins${NC}"
fi
echo ""

# macOS-specific: Aerospace and SwiftBar setup
if [ "$OS" = "Darwin" ]; then
    echo "Aerospace & SwiftBar Setup (macOS only)"
    echo "----------------------------------------"

    # Setup aerospace
    create_symlink "$SCRIPT_DIR/aerospace" "$CONFIG_DIR/aerospace" "aerospace"

    # Setup swiftbar
    create_symlink "$SCRIPT_DIR/swiftbar" "$CONFIG_DIR/swiftbar" "swiftbar"
    echo ""

    # Check if aerospace is installed
    if ! command -v aerospace &> /dev/null; then
        echo -e "${YELLOW}aerospace not found${NC}"
        read -p "Install aerospace via brew? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Installing aerospace..."
            brew install --cask nikitabobko/tap/aerospace
            echo -e "${GREEN}aerospace installed${NC}"
        else
            echo "Skipped aerospace installation"
        fi
    else
        echo -e "${GREEN}aerospace is already installed${NC}"
    fi

    # Check if SwiftBar is installed
    if [ ! -d "/Applications/SwiftBar.app" ]; then
        echo -e "${YELLOW}SwiftBar not found${NC}"
        read -p "Install SwiftBar via brew? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Installing SwiftBar..."
            brew install --cask swiftbar
            echo -e "${GREEN}SwiftBar installed${NC}"
        else
            echo "Skipped SwiftBar installation"
        fi
    else
        echo -e "${GREEN}SwiftBar is already installed${NC}"
    fi

    # Start services
    echo ""
    echo "Starting services..."
    if command -v aerospace &> /dev/null; then
        echo "Starting aerospace..."
        # Aerospace starts automatically at login, but we can reload config
        if pgrep -x "AeroSpace" > /dev/null; then
            aerospace reload-config 2>/dev/null || echo "  Note: Launch aerospace manually if it's not running"
        else
            open -a "AeroSpace"
        fi
    fi

    if [ -d "/Applications/SwiftBar.app" ]; then
        echo "Starting SwiftBar..."
        # Kill existing instance if running
        killall SwiftBar 2>/dev/null || true
        # Start SwiftBar with plugin directory
        open -a SwiftBar
        # Set plugin directory (SwiftBar will use ~/.config/swiftbar)
        defaults write com.ameba.SwiftBar PluginDirectory "$CONFIG_DIR/swiftbar"
    fi

    echo ""
    echo -e "${GREEN}Aerospace & SwiftBar setup complete!${NC}"
    echo "  - Use Alt+h/j/k/l to move focus between windows"
    echo "  - Use Alt+Shift+h/j/k/l to move windows"
    echo "  - Use Alt+0-9 to switch workspaces"
    echo "  - Use Alt+Shift+0-9 to move windows to workspaces"
    echo "  - Use Alt+f to toggle fullscreen"
    echo "  - SwiftBar shows workspace indicator in menu bar"
    echo ""
fi

# Check OS-specific dependencies
echo "System Dependencies"
echo "-------------------"
case "$OS" in
    Darwin)
        echo -e "${GREEN}macOS: pbcopy/pbpaste available by default${NC}"
        ;;
    Linux)
        if command -v xclip &> /dev/null; then
            echo -e "${GREEN}xclip is installed${NC}"
        else
            echo -e "${YELLOW}xclip not found${NC}"
            echo "  Install with: sudo pacman -S xclip  # Arch"
            echo "               sudo apt install xclip  # Ubuntu/Debian"
            echo "               sudo dnf install xclip  # Fedora"
        fi
        ;;
esac
echo ""

# Final instructions
echo "======================================"
echo -e "${GREEN}Installation Complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Launch nvim - plugins will auto-install (powered by lazy.nvim)"
echo "  2. Launch tmux and press Ctrl-Space + I to install tmux plugins"
if [ "$OS" = "Darwin" ]; then
    echo "  3. Aerospace and SwiftBar are running (check menu bar for workspace indicator)"
    echo "  4. Restart your shell to ensure all changes take effect"
else
    echo "  3. Restart your shell to ensure all changes take effect"
fi
echo ""
echo "For nvim LSP servers, run :Mason inside nvim"
