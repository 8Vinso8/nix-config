{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        margin = "10";
        modules-left = [ "hyprland/workspaces" ];
        modules-center= [ "hyprland/window" ];
        modules-right= [
            "tray"
            "cpu"
            "memory"
            "idle_inhibitor"
            "pulseaudio"
            "hyprland/language"
            "clock"
        ];
        "tray" = {
            spacing = 10;
            icon-size = 16;
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
            tooltip = false;
        };
        "hyprland/language" = {
            format-en= "EN";
            format-ru= "RU";
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "<span foreground='#f38ba8'>IDLE</span>";
            deactivated = "IDLE";
          };
        };
      };
    };
  };
}
