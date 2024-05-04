{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
  ];

  xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;
  xdg.configFile."hypr/hypridle.conf".source = ./hypridle.conf;
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/vinso/wallpapers/wall1.jpg
    wallpaper = DP-1,/home/vinso/wallpapers/wall1.jpg
  '';
}
