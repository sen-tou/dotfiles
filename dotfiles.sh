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
DIR=$(dirname $0)

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
    echo "Generate ed25519 SSH key..."
    mkdir -p $SSH_DIR
    chmod 700 $SSH_DIR
    ssh-keygen -t ed25519 -f "$SSH_DIR/id_ed25519" -C "$HOSTNAME@$USER" -N ""
    cat "$SSH_DIR/id_ed25519.pub" >> "$SSH_DIR/authorized_keys"
    chmod 600 "$SSH_DIR/authorized_keys"
    ssh-copy-id -i "$SSH_DIR/id_ed25519.pub" -p $NAS_PORT $NAS_USER@$NAS_HOST
        
    tee -a "$SSH_DIR/config" <<EOF
Host $NAS_HOST	
    User=$NAS_USER 
    Port=$NAS_PORT
    StrictHostKeyChecking=no	
    UserKnownHostsFile=/dev/null
EOF

    eval "$(ssh-agent -s)"
fi

# Check if sshd service is running
if ! systemctl is-active --quiet sshd; then
  systemctl start sshd
  systemctl enable sshd
fi

cd $DIR

source ./setup/install.zsh

source "$HOME/.zshrc"
