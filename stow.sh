set -e
SSH_DIR="$HOME/.ssh"
temp=$(realpath "$0")
DIR="$(dirname "$temp")"

# Setup home dir
stow -t "${1:-$HOME}" -d "${2:-$DIR}" --adopt --restow git zsh ghostty hyprland waybar dunst tmux
git restore

