{ config, pkgs, ... }:

{
  xdg.configFile."alacritty.toml".source = ./alacritty.toml;
}
