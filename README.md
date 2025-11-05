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

## Testing

Tests for features are located in the `test/` directory.

## Contributing

To add a new feature:
1. Create a new directory in `src/` with your feature name
2. Add `devcontainer-feature.json` with feature metadata
3. Add `install.sh` with installation logic
4. Add a `README.md` documenting the feature
5. Add tests in `test/`
