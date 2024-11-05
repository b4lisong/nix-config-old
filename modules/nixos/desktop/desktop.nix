{
  pkgs,
  config,
  lib,
  myvars,
  ...
}: {
  imports = [
    ../base
    ../../base.nix
  ];

  environment.pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw

  services = {
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images

    xserver = {
      enable = true;
      displayManager = {
        lightdm.enable = true;
        autoLogin = {
          enable = true;
          user = myvars.username;
        };
        defaultSession = "none+i3";
      };
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          rofi # application launcher, the same as dmenu
          dunst # notification daemon
          i3blocks # status bar
          i3lock # default i3 screen locker
          xautolock # lock screen after some time
          i3status # provide information to i3bar
          i3-gaps # i3 with gaps
          picom # transparency and shadows
          feh # set wallpaper
          acpi # battery information
          arandr # screen layout manager
          dex # autostart applications
          xbindkeys # bind keys to commands
          xorg.xbacklight # control screen brightness
          xorg.xdpyinfo # get screen information
          sysstat # get system information
        ];
      };
      # Configure keymap in X11
      xkb.layout = "us";
    };
  };
}
