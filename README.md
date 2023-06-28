# Dotfiles

My dotfiles I am using. It has a soft dependency on EndeavourOS for now because I started to create them using that OS.
I have no idea if it will work on a vanilla arch or Manjaro build.

It uses Ansible as automation. I have multiple machines and they get different configs. I achieve this by naming the machines
and running the script based on host name.

Running:
1. Copy config.skeleton to config and change the vars as needed
2. run  `./dotfiles.sh` to let it run

I'll add more information as I please. **Please do not run this script. It is tailored to my setup.**
