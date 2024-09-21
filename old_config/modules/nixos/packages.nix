## Packages specific to nixos-orbstack

{ pkgs }:

with pkgs;
let
  shared_packages = import ../shared/packages.nix { inherit pkgs; };
in shared_packages ++ [
  # Python packages
  python3
  virtualenv

  # Web
  php

  # Port scanning
  nmap

  # Network
  netdiscover
  ncftp
  netcat-gnu
  responder
  whois

  # Password / Hash
  hashcat
  hashcat-utils
  john
  thc-hydra

  # Proxy, pivoting
  chisel
  ligolo-ng
  proxychains-ng

  # Fuzzing
  feroxbuster
  ffuf
  gobuster

  # RE
  radare2
  binwalk

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
  enum4linux-ng
  gomapenum
  kerbrute
  nbtscan
  nbtscanner
  samba
  smbscan

  # Wireless
  aircrack-ng

  # Wordlists
  rockyou
  seclists
]
