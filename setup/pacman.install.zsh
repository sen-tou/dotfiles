# Install yay
sudo pacman -S --needed base-devel git --noconfirm
if ! command -v -- yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si
fi
yay -Syu --noconfirm

# Install apps
yay -S --noconfirm --needed \
    spotify-launcher \
    keepassxc \
    htop \
    exa \
    obsidian \
    fzf \
    wl-clipboard \
    pacman-contrib \
    bluez \
    bluez-utils \
    ttf-cascadia-code-nerd \
    ttf-terminus-nerd \
    ttf-anonymicepro-nerd  \
    neovim \
    ripgrep \
    python \
    python-pip \
    python-pynvim \
    rust \
    php \
    composer \
    git-delta \
    docker \
    docker-compose \
    zsh

# Enable services
sudo systemctl enable --now bluetooth
sudo systemctl enable --now docker
sudo systemctl enable --now docker.socket

# User group settings
sudo usermod -aG docker $USER

# chsh to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
fi
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# Install zsh plugins
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H" ]; then
    git clone https://github.com/z-shell/F-Sy-H.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H
fi
