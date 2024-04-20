{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
      ];
    };
    extraConfig = 
    ''
      monitor=DP-1,2560x1440@165,0x0,1
      monitor=,preferred,auto,1

      $terminal = alacritty
      $fileManager = dolphin
      $menu = wofi --show drun

      exec-once=hypridle
      exec-once=hyprpaper
      exec-once=waybar
      exec-once=dunst
      exec-once=corectrl
      exec-once=discord
      exec-once=spotify

      env = XCURSOR_SIZE,24
      env = GDK_BACKEND,wayland,x11
      env = QT_QPA_PLATFORM,wayland;xcb
      env = SDL_VIDEODRIVER,wayland
      env = CLUTTER_BACKEND,wayland
      env = XDG_CURRENT_DESKTOP,Hyprland
      env = XDG_SESSION_TYPE,wayland
      env = XDG_SESSION_DESKTOP,Hyprland
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = WLR_DRM_NO_ATOMIC,1

      general {
          border_size = 2
          no_border_on_floating = false
          gaps_in = 5
          gaps_out = 0,10,10,10
          col.active_border = rgb(cba6f7)
          col.inactive_border = rgb(303446)
          layout = master
          allow_tearing = true
      }

      decoration {
          rounding = 5
          blur {
              enabled = true
              size = 3
              passes = 1
          }
          drop_shadow = false
      }

      animations {
          enabled = yes
          bezier = myBezier, 0.05, 0.9, 0.1, 1.05
          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      input {
          kb_layout = us,ru
          kb_options = grp:caps_toggle
          follow_mouse = 1
          sensitivity = 0
      }

      master {
          new_is_master = false
          no_gaps_when_only = 1
      }

      misc {
          disable_hyprland_logo = true
          vrr = 2
          mouse_move_enables_dpms = true
          key_press_enables_dpms = true
          no_direct_scanout = false
      }

      windowrulev2 = suppressevent maximize, class:.*
      windowrulev2 = idleinhibit always, fullscreen:1
      windowrulev2 = float,class:^(pavucontrol)$
      windowrulev2 = float,class:^(org.pipewire.Helvum)$
      windowrulev2 = workspace 8 silent,class:^(discord)$
      windowrulev2 = workspace 7 silent,class:^(steam)$
      windowrulev2 = workspace 6, class:steam_app_[0-9]+

      windowrulev2 = immediate, class:^(steam_app_1091500)$ # Cp2077

      windowrulev2 = float,class:^(steam)$,title:^(Steam Settings)$


      $mainMod = SUPER

      bind = $mainMod, Q, exec, $terminal
      bind = $mainMod, C, killactive, 
      bind = $mainMod, M, exit, 
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, F, fullscreen, 
      bind = $mainMod, R, exec, $menu

      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      bind =, XF86AudioPlay, exec, dbus-send --print-reply --dest="org.mpris.MediaPlayer2.spotifyd.instance$(pgrep spotifyd)" /org/mpris/MediaPlayer2 "org.mpris.MediaPlayer2.Player.PlayPause"
      bind =, XF86AudioNext, exec, dbus-send --print-reply --dest="org.mpris.MediaPlayer2.spotifyd.instance$(pgrep spotifyd)" /org/mpris/MediaPlayer2 "org.mpris.MediaPlayer2.Player.Next"
      bind =, XF86AudioPrev, exec, dbus-send --print-reply --dest="org.mpris.MediaPlayer2.spotifyd.instance$(pgrep spotifyd)" /org/mpris/MediaPlayer2 "org.mpris.MediaPlayer2.Player.Previous"
      #bind =, XF86AudioRaiseVolume, exec, playerctl volume 0.05+
      #bind =, XF86AudioLowerVolume, exec, playerctl volume 0.05-

      bind =, XF86AudioMute, exec, pamixer --default-source -t

      bind =, Print, exec, grimblast --freeze copy area

      bind = $mainMod, KP_Add, exec, ddcutil setvcp 10 + 10
      bind = $mainMod, KP_Subtract, exec, ddcutil setvcp 10 - 10

      bind = $mainMod, l, exec, hyprlock
    '';
  };
}
