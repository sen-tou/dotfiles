#!/usr/bin/env bash

echo "=== PACMAN CACHES ==="
du -sh /var/cache/pacman/pkg

echo -e "\n=== AUR BUILDS (yay cache) ==="
if command -v yay &>/dev/null; then
    du -sh ~/.cache/yay
fi

echo -e "\n=== TOP 20 LARGEST PACKAGES ==="
pacman -Qi | awk '/^Name/{name=$3}/^Installed Size/{print $4 $5 " " name}' | \
    sed 's/MiB/ MiB/;s/GiB/ GiB/' | sort -hr | head -n 20

echo -e "\n=== ORPHANED PACKAGES ==="
pacman -Qdtq

echo -e "\n=== UNUSED FLATPAK APPS ==="
if command -v flatpak &>/dev/null; then
    flatpak uninstall --unused --assumeyes
fi

echo -e "\n=== KERNELS INSTALLED ==="
pacman -Q | grep linux

echo -e "\n=== PYTHON GLOBAL PACKAGES ==="
if command -v pip &>/dev/null; then
    pip list --format=columns
fi

echo -e "\n=== NODE GLOBAL PACKAGES ==="
if command -v npm &>/dev/null; then
    npm list -g --depth=0
fi

echo -e "\n=== RUST CARGO INSTALLED BINARIES ==="
if command -v cargo &>/dev/null; then
    cargo install --list
fi

echo -e "\n=== GO MODULE CACHE SIZE ==="
if command -v go &>/dev/null; then
    go clean -modcache -n
fi

echo -e "\n=== DISK USAGE SUMMARY ==="
df -h

echo -e "\nAudit done. Prüfe besonders große Packages, alte Kernel, Orphans, Flatpak/Snap/AppImages und Language Packs für weitere Bereinigung."

