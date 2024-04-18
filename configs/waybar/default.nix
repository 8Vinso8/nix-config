{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        margin-top = 5;
        margin-left = 5;
        margin-right = 5;
        margin-bottom = 5;
        modules-left = [ "hyprland/workspaces" ];
        modules-center= [];
        modules-right= [
            "tray"
            "cpu"
            "memory"
            "pulseaudio"
            "hyprland/language"
            "clock"
        ];
        "tray" = {
            spacing = 10;
        };
        "clock"= {
            format = "{:%d.%m.%y | %H:%M}";
        };
        "cpu"= {
            format = "{usage}%";
            tooltip = false;
        };
        "memory"= {
            format = "{used}GiB|{swapUsed}GiB";
            tooltip = false;
        };
        "pulseaudio"= {
            format = "{format_source}";
            format-source = "MIC";
            format-source-muted = "<span foreground='#f38ba8'>MIC</span>";
            on-scroll-up = "";
            on-scroll-down = "";
        };
        "hyprland/language" = {
            format-en= "EN";
            format-ru= "RU";
        };
      };
    };
  };
}
