#!/usr/bin/env bash
set -e
SSH_DIR="$HOME/.ssh"
temp=$(realpath "$0")
DIR="$(dirname "$temp")"

# Setup home dir
stow -t "${1:-$HOME}" -d "${2:-$DIR}" --adopt --restow git zsh ghostty hyprland waybar dunst tmux
# adoptierte Dateien im Dotfiles-Repo auf den git-Stand zurücksetzen
cd "${2:-$DIR}"
git restore .

# Setup vibe-config (sibling repo in ~/projects)
PROJECTS_DIR="$(dirname "${2:-$DIR}")"
if [ -d "$PROJECTS_DIR/vibe-config" ]; then
    stow -t "${1:-$HOME}" -d "$PROJECTS_DIR" --adopt --restow vibe-config
fi
