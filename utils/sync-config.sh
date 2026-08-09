#!/usr/bin/env bash
#
# sync-config.sh — Sync this repo's canonical custom config into your local
# config directories.
#
# The repo is the source of truth. Each managed path lives here under a
# "source" directory and is mirrored to a destination in your live config:
#
#   repo/crush/            ->  $XDG_CONFIG_HOME/crush/skills/   (Crush skills)
#   repo/lazyvim/          ->  $XDG_CONFIG_HOME/nvim/lua/        (LazyVim Lua config)
#
# Usage:
#   ./utils/sync-config.sh            # push (repo -> local); default
#   ./utils/sync-config.sh --pull     # pull (local -> repo)
#   ./utils/sync-config.sh --dry-run  # show what would change, change nothing
#
# Requires: bash 4+, rsync.

set -euo pipefail

# --- resolve source root (this repo) -------------------------------------
SOURCE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# --- destinations --------------------------------------------------------
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
CRUSH_DEST="$XDG_CONFIG_HOME/crush"
NVIM_LUA="$XDG_CONFIG_HOME/nvim/lua"

# --- flags ---------------------------------------------------------------
MODE="push"
DO_DRY_RUN=0

for arg in "$@"; do
  case "$arg" in
    --pull) MODE="pull" ;;
    --dry-run) DO_DRY_RUN=1 ;;
    -h|--help)
      sed -n '2,10p' "${BASH_SOURCE[0]}"
      echo
      echo "  --pull      copy FROM local config INTO the repo (overwrites repo files)"
      echo "  --dry-run   report actions without changing anything"
      exit 0
      ;;
    *)
      echo "unknown option: $arg" >&2
      exit 1
      ;;
  esac
done

RSYNC_ARGS=(-a --delete)
if (( DO_DRY_RUN )); then
  RSYNC_ARGS+=(-n)
fi

# Mirror a directory pair.
sync_dir() {
  local src="$1" dest="$2" name="$3"
  if (( DO_DRY_RUN )) && [[ ! -d "$dest" ]]; then
    echo "[dry-run] would create $name destination: $dest"
    return 0
  fi
  mkdir -p "$dest"
  if [[ "$MODE" == "push" ]]; then
    rsync "${RSYNC_ARGS[@]}" "$src/" "$dest/"
  else
    rsync "${RSYNC_ARGS[@]}" "$dest/" "$src/"
  fi
  echo "[${MODE}] synced $name: $( ((DO_DRY_RUN)) && echo "(dry-run) ")src=$src dest=$dest"
}

sync_dir  "$SOURCE_ROOT/crush"      "$CRUSH_DEST"  "Crush config"
sync_dir  "$SOURCE_ROOT/lazyvim"    "$NVIM_LUA"    "LazyVim Lua config"

echo
echo "Done. (mode=$MODE)"
