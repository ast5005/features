# Dev Container Features

This repository contains a collection of development container features.

## Features

Features in this repository are available as container features that can be referenced in a `devcontainer.json` file.

## Usage

To use a feature from this repository, reference it in your `devcontainer.json`:

```json
{
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "ghcr.io/your-username/features/feature-name:1": {}
  }
}
```

## Available Features

Features are located in the `src/` directory. Each feature contains:
- `devcontainer-feature.json` - Feature metadata and options
- `install.sh` - Installation script
- `README.md` - Feature documentation

### Current Features

- **[claude](src/claude)** - Installs Claude Code CLI with automatic OS detection

## Publishing Features to GHCR

To use your features in other projects, you must publish them to GitHub Container Registry:

### Steps to Publish:

1. **Push your code to GitHub**
   ```bash
   git add .
   git commit -m "Add devcontainer features"
   git push origin main
   ```

2. **Run the GitHub Actions workflow**
   - Go to your repository on GitHub
   - Navigate to **Actions** tab
   - Click on "Release dev container features & Generate Documentation"
   - Click **Run workflow** → **Run workflow**

3. **Make packages public** (Required for free tier)
   - Go to https://github.com/users/ast5005/packages
   - Find your published feature packages (e.g., `features/claude`)
   - Click on the package → **Package settings**
   - Scroll down to **Danger Zone**
   - Click **Change visibility** → Select **Public**

4. **Verify publication**
   - Features will be available at: `ghcr.io/ast5005/features/claude:1`

### Note on Versioning

Features are only republished when you update the `version` field in `devcontainer-feature.json`. If you make changes:
1. Update the version number (e.g., from `1.0.0` to `1.0.1`)
2. Push changes to main
3. Workflow will automatically publish the new version

## Testing

Tests for features are located in the `test/` directory.

## Contributing

To add a new feature:
1. Create a new directory in `src/` with your feature name
2. Add `devcontainer-feature.json` with feature metadata
3. Add `install.sh` with installation logic
4. Add a `README.md` documenting the feature
5. Add tests in `test/`
6. Update the version and publish to GHCR
