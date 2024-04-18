{ config, pkgs, ... }:

{
  xdg.configFile."alacritty/alacritty.toml".source = ./alacritty.toml;
}
