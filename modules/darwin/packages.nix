## macOS-specific Nix packages
{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  dockutil
  # Comms / office
  zoom-us
  slack
  #VMs
  utm
  # General packages for development and system mgmt
  aspell
  aspellDicts.en
  ranger
  lazygit
  # Common clients for various protocol connections
  freerdp3
  ntp
  openssh
  samba
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
  hunspell
  kitty
  # Python
  python39
  python39Packages.virtualenv
  # IDE & Editor
  vscode
  glow
]
