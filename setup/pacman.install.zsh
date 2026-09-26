# Install yay
if ! command -v -- yay &> /dev/null; then
    sudo pacman -S --needed base-devel git --noconfirm
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si)
fi

# Install apps
yay -S --noconfirm --needed \
    stow \
    keepassxc \
    htop \
    eza \
    fzf \
    wl-clipboard \
    pacman-contrib \
    bluez \
    bluez-utils \
    ttf-cascadia-code-nerd \
    ttf-terminus-nerd \
    ttf-anonymouspro-nerd \
    ttf-liberation-mono-nerd \
    neovim \
    ripgrep \
    python \
    python-pip \
    python-pynvim \
    php \
    composer \
    git-delta \
    docker \
    docker-compose \
    zsh \
    zoxide \
    ghostty

# Enable services
sudo systemctl enable --now bluetooth
sudo systemctl enable --now docker
sudo systemctl enable --now docker.socket

# User group settings
sudo usermod -aG docker "$USER"

# chsh to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    sudo chsh -s "$(which zsh)" "$USER"
fi
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# Install zsh plugins
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
fi
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H" ]; then
    git clone https://github.com/z-shell/F-Sy-H.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H"
fi

# Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
