{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
  ];

  xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;
}
