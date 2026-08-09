# my-profile

Shared, version-controlled configuration for my development environment.
This repo is the source of truth for custom config; `utils/sync-config.sh`
mirrors it into your live config directories.

## What's here

| Path | Destination | Purpose |
| --- | --- | --- |
| `crush/` | `$XDG_CONFIG_HOME/crush/skills/` | Custom Crush skills (architect, reviewer) |
| `lazyvim/crush.lua` | `$XDG_CONFIG_HOME/nvim/lua/plugins/crush.lua` | neocrush.nvim plugin config for LazyVim |
| `utils/sync-config.sh` | — | Syncs the above into your local config |

## Prerequisites (macOS)

Before using this repo, install the following tools. This assumes
[Homebrew](https://brew.sh) for package management.

### Neovim

```bash
brew install neovim
```

Confirmed working with Neovim 0.9+.

### LazyVim

[LazyVim](https://www.lazyvim.org) is a Neovim distribution built on the
lazy.nvim plugin manager. Install it from the `lazyvim` starter:

```bash
# backup any existing config
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

# clone the starter
git clone https://github.com/LazyVim/starter ~/.config/nvim
```

Then remove the `.git` folder so it's your own config:

```bash
rm -rf ~/.config/nvim/.git
```

### Crush

[Crush](https://github.com/taigrr/crush) is the CLI AI assistant that powers
the neocrush.nvim plugin in `lazyvim/crush.lua`. On macOS it is typically
installed as a Go binary:

```bash
go install github.com/taigrr/crush@latest
```

Make sure `$(go env GOPATH)/bin` is on your `$PATH` so Neovim can launch
`crush` from the terminal:

```bash
# add to ~/.zshrc
export PATH="$(go env GOPATH)/bin:$PATH"
```

Verify everything is wired up:

```bash
nvim --version   # Neovim installed
crush --version  # Crush installed
```

## Usage

Sync this repo into your live config:

```bash
# push: repo -> local config (default)
./utils/sync-config.sh

# preview what would change without touching anything
./utils/sync-config.sh --dry-run

# pull: local config -> repo (use when you've edited locally and want to save)
./utils/sync-config.sh --pull
```

Requires `bash 4+` and `rsync` (both present by default on macOS).
