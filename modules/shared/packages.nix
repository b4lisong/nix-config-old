## Shared packages across all environments
## Keep this small!
{ pkgs }:

with pkgs; [
  # Development & system mgmt
  bash-completion
  bat
  coreutils
  difftastic
  killall
  wget

  # System monitoring
  btop
  iftop
  htop

  # Text & terminal utilities
  jq
  ripgrep
  tree
  tmux
  starship

  # Archiving
  unrar
  unzip
  cabextract
  p7zip
  zip

  # Misc.
  neofetch
]
