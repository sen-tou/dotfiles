#!/bin/bash
# ******************************************************************************
# Init script for dotfiles
#
# This script will install and configure everything needed on the system
# It requires an arch based linux distribution using systemd
#
# ******************************************************************************

# throw errors if any
set -e
SSH_DIR="$HOME/.ssh"
temp=$(realpath "$0")
DIR="$(dirname $temp)"
# Load local config
if [ -f "$DIR/config" ]; then 
    source "$DIR/config"
else
    echo "Please copy the config.skeleton to config and fill in the values"
    exit 1
fi

# Echo a sudo rule for the user to a file in sudoers.d directory
if ! sudo test -f "/etc/sudoers.d/$USER"; then
    echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee "/etc/sudoers.d/$USER"
fi 

# Install ssh
if ! command -v ssh &> /dev/null; then
    sudo pacman -Sy --noconfirm openssh
fi

# Generate ssh key if not exits
if ! [ -f "$SSH_DIR/id_ed25519" ]; then
    mkdir -p $SSH_DIR
    chmod 700 $SSH_DIR
    
    tee -a "$SSH_DIR/config" <<EOF
Host $NAS_HOST	
    User=$NAS_USER 
    Port=$NAS_PORT
    StrictHostKeyChecking=no	
    UserKnownHostsFile=/dev/null
EOF

    eval "$(ssh-agent -s)"
fi

cd $DIR
echo $DIR
# source ./setup/install.zsh

stow -t $HOME -d $DIR --restow git 

source "$HOME/.zshrc"
