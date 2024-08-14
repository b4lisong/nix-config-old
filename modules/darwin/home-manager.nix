{ config, pkgs, lib, home-manager, ... }:

let
  user = "balisong";
  # Define the content of your file as a derivation
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
   ./dock
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  # System defaults
  system.defaults = {
    NSGlobalDomain = {
      AppleICUForce24HourTime = true; # force 24-hour clock
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true; # show all file exts in Finder
      AppleShowAllFiles = true; # always show hidden files
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXDefaultSearchScope = "SCcf"; # default search scope: current folder
      FXPreferredViewStyle = "clmv"; # default to column view
      ShowPathbar = true;
      ShowStatusBar = true;
    };
  };
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  homebrew = {
    enable = true;
    global = {
      autoUpdate = true;
      brewfile = true;
    };
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    taps = [ "homebrew/cask" "nikitabobko/tap" ]; # must be defined here to avoid untap warning
    casks = pkgs.callPackage ./casks.nix {};
    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)

    masApps = {
      # "1password" = 1333542190; # using cask instead
      "1Password for Safari" = 1569813296;
      "wireguard" = 1451685025;
      # "tailscale" = 1475387142; # not working? use cask?
    };
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        file = lib.mkMerge [
          sharedFiles
          additionalFiles
        ];

        stateVersion = "23.11";
      };
      programs = {
      } // import ../shared/home-manager.nix { inherit config pkgs lib; };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };

  # System services
  services = {
    # Janky borders
    jankyborders = {
      enable = true;
      active_color = "gradient(top_right=0xffa6e3a1,bottom_left=0xff89b4fa)";
      inactive_color = "0x33585b70";
      hidpi = true;
      width = 5.0;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local = { 
    dock = {
      enable = true;
      entries = [
        { path = "/System/Applications/Messages.app/"; }
        { path = "${pkgs.slack}/Applications/Slack.app/"; }
        { path = "/Applications/Superhuman.app/"; }
        { path = "/Applications/Todoist.app/"; }
        { path = "/Applications/Sunsama.app/"; }
        { path = "/Applications/Logseq.app/"; }
        { path = "${pkgs.kitty}/Applications/kitty.app/"; }
        { path = "/Applications/1Password.app/"; }
        #{
        #  path = toString myEmacsLauncher;
        #  section = "others";
        #}
        {
          path = "${config.users.users.${user}.home}/.local/share/";
          section = "others";
          options = "--sort name --view grid --display folder";
        }
        {
          #path = "${config.users.users.${user}.home}/.local/share/downloads";
          path = "${config.users.users.${user}.home}/Downloads";
          section = "others";
          options = "--sort name --view grid --display stack";
        }
      ];
    };
  };
}
