{ config, pkgs, lib, ... }:

let
  user = "balisong";
  xdg_configHome = "/home/${user}/.config";
  shared_programs = import ../shared/home-manager.nix { inherit config pkgs lib; };
in
{
  home = {
    enableNixpkgsReleaseCheck = false;
    packages = pkgs.callPackage ./packages.nix {};
    stateVersion = "24.11";
  };
  programs = shared_programs;
}
