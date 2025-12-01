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
        linux)
            # Check for required dependencies
            if ! command_exists curl; then
                echo "Error: curl is required but not installed."
                echo "Please install curl and try again."
                exit 1
            fi

            # Install via shell script
            echo "Installing Claude Code via install script..."

            if [ "$VERSION" = "latest" ] || [ -z "$VERSION" ]; then
                echo "Installing latest version of Claude Code..."
                curl -fsSL https://claude.ai/install.sh | bash
            else
                echo "Installing Claude Code version $VERSION..."
                curl -fsSL https://claude.ai/install.sh | bash -s "$VERSION"
            fi
            ;;
        *)
            echo "Error: Unsupported OS type '$OS_TYPE'."
            echo "Only 'linux' is supported."
            exit 1
            ;;
    esac
}

# Make Claude binary accessible to all users
make_globally_accessible() {
    echo "Making Claude binary accessible to all users..."

    # Common locations where Claude might be installed
    POSSIBLE_LOCATIONS=(
        "/root/.local/bin/claude"
        "$HOME/.local/bin/claude"
    )

    CLAUDE_BINARY=""
    for location in "${POSSIBLE_LOCATIONS[@]}"; do
        if [ -f "$location" ]; then
            CLAUDE_BINARY="$location"
            echo "Found Claude binary at: $CLAUDE_BINARY"
            break
        fi
    done

    # If not found in common locations, try to find it
    if [ -z "$CLAUDE_BINARY" ] && command_exists claude; then
        CLAUDE_BINARY=$(which claude)
        echo "Found Claude binary at: $CLAUDE_BINARY"
    fi

    if [ -n "$CLAUDE_BINARY" ]; then
        # If it's not already in /usr/local/bin, create a symlink
        if [ "$CLAUDE_BINARY" != "/usr/local/bin/claude" ]; then
            echo "Creating symlink in /usr/local/bin for global access..."

            # Remove existing symlink or file if it exists
            if [ -L "/usr/local/bin/claude" ] || [ -f "/usr/local/bin/claude" ]; then
                rm -f /usr/local/bin/claude
            fi

            # Create symlink
            ln -s "$CLAUDE_BINARY" /usr/local/bin/claude
            echo "✓ Created symlink: /usr/local/bin/claude -> $CLAUDE_BINARY"
        fi

        # Make the original binary executable by all users
        chmod 755 "$CLAUDE_BINARY"
        echo "✓ Claude binary is now accessible to all users"
    else
        echo "⚠ Warning: Could not locate Claude binary to make globally accessible"
    fi
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
    make_globally_accessible
    verify_installation

    echo "================================================"
    echo "Feature 'claude' installation complete!"
    echo "================================================"
    echo ""
    echo "To use Claude Code, run: claude"
}

main
