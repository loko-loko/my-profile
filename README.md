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

## Keybindings

`<leader>` is `Space` by default in LazyVim.

### Run Crush (AI agent)

| Shortcut | Action |
| --- | --- |
| `<leader>cc` | Open/toggle the Crush agent in a vertical split |
| `ac` | Alias for the above |

Inside the Crush terminal, use `:CodockFilePosPaste @` (or the `CodockActions`
popup) to send the current file and line to Crush.

### Switch between files (buffers)

| Shortcut | Action |
| --- | --- |
| `<C-^>` | Toggle to the previous file |
| `<leader>ff` | File picker (find files) |
| `<leader>fr` | Open recently opened files |
| `<leader>fb` | List open buffers |
| `:bnext` / `:bprev` | Go to the next / previous buffer |
| `<leader>bd` | Delete (close) the current buffer |

### Switch between panels

| Shortcut | Action |
| --- | --- |
| `<C-w>h` / `<C-w>l` | Move to the left / right split |
| `<C-w>j` / `<C-w>k` | Move to the split below / above |
| `<C-w><C-w>` | Cycle to the next split |
| `<C-w>=` | Equalize split sizes |

### Switch between tabs

| Shortcut | Action |
| --- | --- |
| `<tab>` | Go to the next tab | | `<S-tab>` | Go to the previous tab |
| `<leader>1` ... `<leader>9` | Go to tab by number |
| `<leader>t` | Open a new tab |
| `<leader>T` | Close the current tab |

### Run a terminal

| Shortcut | Action |
| --- | --- |
| `<leader>ft` | Toggle the floating terminal |
| `<leader>fT` | Open a new terminal in a split |
| `<C-\><C-n>` | Exit terminal mode back to normal mode |

### Run LazyGit

| Shortcut | Action |
| --- | --- |
| `<leader>gg` | Open LazyGit |
| `<leader>gG` | Open LazyGit in a floating window |
| `q` | Close LazyGit and return to Neovim |
