# AGENTS.md

This repository is **not application source code**. It is the version-controlled
source of truth for a personal development environment (Crush AI skills +
LazyVim/Neovim config). There is no build, test, or lint step. The only
executable is a config-sync shell script.

## What this repo is

`utils/sync-config.sh` mirrors the repo's config directories into the live
config directories on the machine. The repo is canonical; local config is a
mirror. Two directory pairs are managed:

| Repo path | Live destination | Purpose |
| --- | --- | --- |
| `crush/` | `$XDG_CONFIG_HOME/crush/skills/` | Custom Crush skills |
| `lazyvim/` | `$XDG_CONFIG_HOME/nvim/lua/` | LazyVim Lua config |

`$XDG_CONFIG_HOME` defaults to `$HOME/.config` when unset.

## Essential commands

There is no build/test/lint. The only workflow is syncing config:

```bash
./utils/sync-config.sh            # push: repo -> local config (default)
./utils/sync-config.sh --dry-run  # preview changes, change nothing
./utils/sync-config.sh --pull     # pull: local config -> repo (overwrites repo files)
./utils/sync-config.sh --help     # usage
```

Requires `bash 4+` and `rsync` (both present by default on macOS).

## Gotchas

- **`--pull` overwrites repo files.** It runs `rsync --delete` in reverse
  (local -> repo). Any local edits you want to keep must be pulled back into
  the repo, or they will be lost on the next push. This is the intended
  workflow: edit locally, then `--pull` to save.
- **`rsync --delete` is always on.** Files present in the destination but not
  the source are removed. Do not hand-place extra files in the live config
  directories that are managed here, or a push will delete them.
- **`crush/` syncs the whole directory**, including `crush.json`. The
  `crush.json` here is minimal (only a `permissions.allowed_tools` of `view`).
- **`lazyvim/` syncs into `nvim/lua/`**, so `lazyvim/config/*.lua` becomes
  `nvim/lua/config/*.lua` and `lazyvim/plugins/*.lua` becomes
  `nvim/lua/plugins/*.lua`. This is the standard LazyVim layout.

## Code organization

### `crush/skills/<name>/SKILL.md`

Crush skills. Each is a Markdown file with YAML frontmatter:

```yaml
---
name: <skill-name>
description: <when to use this skill>
user-invocable: true
---
```

Two skills exist: `architect` (design/plan before implementation, stops for
review) and `reviewer` (quality-gate review, reports findings without fixing).
Both follow a strict workflow + output-format structure. When adding a skill,
match this frontmatter + sectioned format.

### `lazyvim/config/`

LazyVim core overrides, loaded automatically before lazy.nvim startup:
- `lazy.lua` — the lazy.nvim bootstrap and `require("lazy").setup({...})`.
  Imports `lazyvim.plugins`, the markdown extra, and the local `plugins` dir.
- `options.lua`, `keymaps.lua`, `autocmds.lua` — currently empty stubs with
  header comments pointing to LazyVim defaults. Add overrides here.

### `lazyvim/plugins/`

LazyVim plugin specs, each file auto-loaded by lazy.nvim. Each returns a
table of spec entries (add, override, or disable LazyVim plugins).
- `crush.lua` — wires up `gitsang/codock.nvim` to launch the `crush` CLI in a
  vertical split (`<leader>cc` / `ac`), and disables LazyVim's codelens
  `<leader>cc` keymap so it doesn't collide.
- `markdown.lua` — overrides `render-markdown.nvim` code-block rendering.
- `example.lua` — a no-op template (`if true then return {} end`); it is
  intentionally disabled and shows the spec patterns. Do not treat it as live.

### `utils/sync-config.sh`

The sync script. Reads `SOURCE_ROOT` from its own location, resolves
destinations, parses `--pull`/`--dry-run`/`--help`, and mirrors each pair with
`rsync -a --delete`.

## Conventions

- **Lua files use tabs for indentation** (see `lazy.lua`, `markdown.lua`).
  `example.lua` uses spaces and is stylua-ignored; it is a template, not a
  style reference.
- Plugin specs follow LazyVim conventions: `opts` for config overrides,
  `keys`/`cmd`/`event` for lazy-loading, `{ import = "..." }` for extras.
- Shell script uses `set -euo pipefail` and a `sync_dir` helper for the
  mirrored pairs.
- README.md documents prerequisites (Neovim 0.9+, LazyVim starter, Crush via
  `go install github.com/taigrr/crush@latest`) and keybindings. Keep it in
  sync when adding config.

## Testing / verification

No automated tests. To verify a change:
1. Run `./utils/sync-config.sh --dry-run` to confirm the intended files map.
2. Run `./utils/sync-config.sh` to apply.
3. For Neovim changes, restart Neovim and check `:Lazy` for plugin errors.
4. For Crush skill changes, verify the skill loads (frontmatter is valid).
