#!/bin/bash
set -e

echo "Activating feature 'claude'"

# Get options from environment variables (passed from devcontainer.json)
VERSION=${VERSION:-"latest"}
# OSTYPE from devcontainer.json (default to linux if not set)
OS_TYPE=${OSTYPE:-"linux"}

echo "Configuration:"
echo "  OS Type: $OS_TYPE"
echo "  Version: $VERSION"

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Claude Code
install_claude() {
    echo "Installing Claude Code for OS: $OS_TYPE"

    case "$OS_TYPE" in
        linux|macos|wsl)
            # Check for required dependencies
            if ! command_exists curl; then
                echo "Error: curl is required but not installed."
                echo "Please install curl and try again."
                exit 1
            fi

            # Try Homebrew first if available
            if command_exists brew; then
                echo "Installing Claude Code via Homebrew..."
                brew install --cask claude-code || echo "Homebrew installation failed, falling back to install script..."
            fi

            # Fallback to shell script installation
            if ! command_exists claude; then
                echo "Installing Claude Code via install script..."

                if [ "$VERSION" = "latest" ] || [ -z "$VERSION" ]; then
                    echo "Installing latest version of Claude Code..."
                    curl -fsSL https://claude.ai/install.sh | bash
                else
                    echo "Installing Claude Code version $VERSION..."
                    curl -fsSL https://claude.ai/install.sh | bash -s "$VERSION"
                fi
            fi
            ;;
        windows)
            echo "Error: Windows installation in devcontainer is not typical."
            echo "For Windows containers, use one of the following:"
            echo "  PowerShell: irm https://claude.ai/install.ps1 | iex"
            echo "  Command Prompt: curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd"
            exit 1
            ;;
        *)
            echo "Warning: Unknown OS type '$OS_TYPE', defaulting to linux installation method..."
            curl -fsSL https://claude.ai/install.sh | bash
            ;;
    esac
}

# Verify installation
verify_installation() {
    echo "Verifying Claude Code installation..."

    # Give it a moment for the installation to complete
    sleep 2

    if command_exists claude; then
        echo "✓ Claude Code installed successfully!"
        claude --version || echo "Installed, but version check failed"
    else
        echo "⚠ Warning: Claude Code command not found in PATH."
        echo "You may need to restart your shell or source your profile."
    fi
}

# Main installation flow
main() {
    echo "================================================"
    echo "Installing Claude Code"
    echo "================================================"

    install_claude
    verify_installation

    echo "================================================"
    echo "Feature 'claude' installation complete!"
    echo "================================================"
    echo ""
    echo "To use Claude Code, run: claude"
}

main
