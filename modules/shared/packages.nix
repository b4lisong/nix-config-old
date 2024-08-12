{ pkgs }:

with pkgs; [
  # General packages for development and system management
  aspell
  aspellDicts.en
  bash-completion
  bat
  coreutils
  killall
  lazygit
  neofetch
  nnn
  sqlite
  wget

  # System monitoring
  btop
  iftop

  # Common clients for various protocol connections
  freerdp3
  ntp
  openssh
  samba
  tigervnc

  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg
  libfido2

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Media-related packages
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  hack-font
  noto-fonts
  noto-fonts-emoji
  meslo-lgs-nf

  # Text and terminal utilities
  htop
  hunspell
  jetbrains-mono
  jq
  kitty
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

  # Python packages
  # Seems to be an issue with python 3.12?
  #python3
  #virtualenv
  python39
  python39Packages.virtualenv # globally install virtualenv
  python311

  ## Pentest tools
  # Network
  netdiscover
  ncftp
  netcat-gnu
  responder
  whois
  # Password / Hashing
  hashcat
  hashcat-utils
  john
  thc-hydra
  # Port scan
  nmap
  rustscan
  # Proxy & pivoting
  chisel
  ligolo-ng
  proxychains-ng
  # Fuzzing
  feroxbuster
  ffuf
  gobuster
  # RE / Malware Analysis
  radare2
  binwalk
  # Services
  #metasploit
  sqlmap
  braa
  onesixtyone
  snmpcheck
  davtest
  # Web
  apachetomcatscanner
  nikto
  whatweb
  wprecon
  #wpscan
  # Windows
  bloodhound-py
  enum4linux-ng
  gomapenum
  kerbrute
  nbtscan
  nbtscanner
  samba
  smbmap
  smbscan
  # Wireless
  aircrack-ng
  # Wordlists
  rockyou
  seclists

]
