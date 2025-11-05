# Claude Code (claude)

Installs [Claude Code](https://claude.ai/code), Anthropic's official CLI for Claude, in your development container with automatic OS detection.

## Example Usage

### Basic Installation (Linux, default latest version)

```json
"features": {
    "ghcr.io/your-username/features/claude:1": {}
}
```

### With Specific Version

```json
"features": {
    "ghcr.io/your-username/features/claude:1": {
        "version": "1.0.58"
    }
}
```

### With Custom OS Type

```json
"features": {
    "ghcr.io/your-username/features/claude:1": {
        "osType": "macos",
        "version": "latest"
    }
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Version of Claude Code to install | string | latest |
| osType | Operating system type (linux, macos, wsl) | string | linux |

## What it does

This feature installs Claude Code CLI with intelligent OS detection:

1. **Checks the OS type** - Uses the `osType` option (defaults to `linux`)
2. **Installs via Homebrew** - If available on the system
3. **Falls back to install script** - Uses the official Claude Code installation script
4. **Verifies installation** - Confirms Claude Code is properly installed

After installation, you can use Claude Code:
```bash
claude
```

## System Requirements

- **Operating Systems**: Linux (Ubuntu 20.04+/Debian 10+), macOS 10.15+, or WSL
- **Dependencies**: `curl` (automatically checked)
- **Network**: Internet connection required

## Notes

- The feature will default to `linux` if `osType` is not specified
- Homebrew installation is attempted first if available
- The official installation script is used as a fallback
- Installation is verified after completion
