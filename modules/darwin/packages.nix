## macOS-specific Nix packages
{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  dockutil
  # General packages for development and system mgmt
  ranger
  lazygit
  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg
  libfido2
  # Fonts
  dejavu_fonts
  font-awesome
  hack-font
  noto-fonts
  noto-fonts-emoji
  meslo-lgs-nf
  jetbrains-mono
  # Text & terminal
  kitty
  # Python
  python39
  python39Packages.virtualenv
]
