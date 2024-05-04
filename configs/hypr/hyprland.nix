{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
        "hypridle"
        "hyprpaper"
        "waybar"
        "dunst"
        "corectrl"
        "discord"
        "nekoray -tray"
        "spotify"
      ];

      monitor = [
        "DP-1,2560x1440@165,0x0,1"
        ",preferred,auto,1"
      ];

      "$terminal" = "alacritty";
      "$menu" = "wofi --show drun";
      "$mainMod" = "SUPER";

      env = [
        "GDK_BACKEND,wayland,x11"
        "QT_QPA_PLATFORM,wayland;xcb"
        "CLUTTER_BACKEND,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];

      general = {
        border_size = 2;
        no_border_on_floating = true;
        gaps_in = 5;
        gaps_out = "0,10,10";
        "col.active_border" = "rgb(cba6f7)";
        "col.inactive_border" = "rgb(303446)";
        layout = "master";
        allow_tearing = false;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        drop_shadow = false;
      };

      animations = {
        enabled = "yes";
        first_launch_animation = false;
        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:caps_toggle";
        follow_mouse = 1;
        sensitivity = 0;
      };

      master = {
        new_is_master = false;
      };

      misc = {
        disable_hyprland_logo = true;
        vrr = 2;
      };

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "idleinhibit always, fullscreen:1"
        "float,class:^(pavucontrol)$"
        "workspace 8 silent,class:^(discord)$"
        "workspace 7 silent,class:^(steam)$"
        "workspace 6, class:steam_app_[0-9]+"
        "workspace 5 silent,class:^(Spotify)$"
        "float,class:^(steam)$,title:^(Steam Settings)$"
      ];

      bind = [
        "$mainMod, C, killactive, "
        "$mainMod, M, exit, "
        "$mainMod, V, togglefloating,"
        "$mainMod, F, fullscreen, "
        "$mainMod, R, exec, $menu"
        "$mainMod, Q, exec, $terminal"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioRaiseVolume, exec, playerctl volume 0.05+"
        ", XF86AudioLowerVolume, exec, playerctl volume 0.05-"
        ", XF86AudioMute, exec, pamixer --default-source -t"
        ", Print, exec, grimblast --freeze copy area"
        "$mainMod, KP_Add, exec, ddcutil setvcp 10 + 10"
        "$mainMod, KP_Subtract, exec, ddcutil setvcp 10 - 10"
        "$mainMod, l, exec, hyprlock"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
