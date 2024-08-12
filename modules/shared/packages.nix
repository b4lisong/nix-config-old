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
  iotop

  # Common clients for various protocol connections
  cifs-utils
  freerdp
  net-snmp
  nfs-utils
  ntp
  openssh
  samba
  tightvnc

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
  python39
  python39Packages.virtualenv # globally install virtualenv

  ## Pentest tools
  # Network
  iputils
  netexec
  netdiscover
  ncftp
  netcat-gnu
  responder
  whois
  # Password / Hashing
  hashcat
  hashcat-utils
  john
  medusa
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
  gdb
  radare2
  python3Packages.binwalk
  # Services
  metasploit
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
  wpscan
  # Windows
  bloodhound-py
  enum4linux-ng
  evil-winrm
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
