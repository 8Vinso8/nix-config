{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
  ];

  xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;
  xdg.configFile."hypr/hypridle.conf".source = ./hypridle.conf;
}
