#!/usr/bin/env bash
set -Eeuo pipefail

die() {
    printf 'Fehler: %s\n' "$*" >&2
    exit 1
}

command -v pacman >/dev/null 2>&1 || die "Dieses Skript benötigt Arch Linux oder eine Arch-basierte Distribution."
[[ $EUID -ne 0 ]] || die "Bitte als normaler Benutzer starten, nicht mit sudo."

user=$(id -un)
home=$(getent passwd "$user" | cut -d: -f6)
[[ -n $home && -d $home ]] || die "Home-Verzeichnis für '$user' wurde nicht gefunden."

# sudo-Ticket vor jedem längeren sudo-Block auffrischen
sudo -v

# Werkzeuge für yay, GitHub-Downloads und Builds
sudo pacman -S --needed --noconfirm base-devel git curl

# yay installieren, falls es noch fehlt
if ! command -v yay >/dev/null 2>&1; then
    tmpdir=$(mktemp -d)
    trap 'rm -rf "$tmpdir"' EXIT

    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    (
        cd "$tmpdir/yay"
        makepkg -si --noconfirm
    )
fi

command -v yay >/dev/null 2>&1 || die "yay ist nach der Installation nicht verfügbar."

# Pakete installieren
yay -S --needed --noconfirm \
    stow \
    tmux \
    keepassxc \
    htop \
    fzf \
    wl-clipboard \
    ttf-liberation-mono-nerd \
    neovim \
    ripgrep \
    git-delta \
    docker \
    docker-compose \
    zsh \
    zoxide \
    ghostty

# sudo-Ticket kann nach der langen Installation abgelaufen sein
sudo -v

# Docker beim Systemstart starten
sudo systemctl enable --now docker.service

# Zugriff auf Docker für den aktuellen Benutzer
sudo usermod -aG docker "$user"

# zsh als Login-Shell setzen
zsh_path=$(command -v zsh) || die "zsh wurde nicht gefunden."
[[ -x $zsh_path ]] || die "Die gefundene zsh ist nicht ausführbar: $zsh_path"

if ! grep -Fxq "$zsh_path" /etc/shells; then
    printf '%s\n' "$zsh_path" | sudo tee -a /etc/shells >/dev/null
fi

current_shell=$(getent passwd "$user" | cut -d: -f7)
if [[ $current_shell != "$zsh_path" ]]; then
    sudo usermod --shell "$zsh_path" "$user"
fi

# Oh My Zsh installieren, ohne eine weitere Shell-Änderung anzustoßen
if [[ ! -d "$home/.oh-my-zsh" ]]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
        "" --unattended --keep-zshrc
fi

zsh_custom=${ZSH_CUSTOM:-"$home/.oh-my-zsh/custom"}
mkdir -p "$zsh_custom/plugins"

# Plugins
if [[ ! -d "$zsh_custom/plugins/zsh-autosuggestions/.git" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$zsh_custom/plugins/zsh-autosuggestions"
fi

if [[ ! -d "$zsh_custom/plugins/F-Sy-H/.git" ]]; then
    git clone https://github.com/z-shell/F-Sy-H.git \
        "$zsh_custom/plugins/F-Sy-H"
fi

# Tmux Plugin Manager
mkdir -p "$home/.tmux/plugins"
if [[ ! -d "$home/.tmux/plugins/tpm/.git" ]]; then
    git clone https://github.com/tmux-plugins/tpm \
        "$home/.tmux/plugins/tpm"
fi

printf '\nFertig. Melde dich ab und wieder an, damit die neue Shell und Docker-Gruppenmitgliedschaft greifen.\n'
