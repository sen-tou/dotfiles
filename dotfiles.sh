#!/bin/bash
# ******************************************************************************
# Init script for dotfiles
#
# This script will install and configure everything needed on the system
# It requires an arch/debian based linux distribution using systemd
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

# Setup NAS
chmod 0700 $SSH_DIR 
SSH_FILE="$SSH_DIR/config"
touch $SSH_FILE && chmod 0600 $SSH_FILE
HOST_STRING="Host $NAS_HOST"
if ! grep -qF "$HOST_STRING" "$SSH_FILE"; then
    tee -a $SSH_FILE <<EOF
$HOST_STRING	
    User=$NAS_USER 
    Port=$NAS_PORT
    StrictHostKeyChecking=no	
    UserKnownHostsFile=/dev/null
EOF
fi

cd $DIR
if command -v apt >/dev/null 2>&1; then
    source ./setup/apt.install.zsh
elif command -v pacman >/dev/null 2>&1; then
    source ./setup/pacman.install.zsh
else
    echo "This system does not support package install. Skipping"
fi

./stow.sh $HOME $DIR
