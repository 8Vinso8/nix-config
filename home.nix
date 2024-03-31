{ config, pkgs, ... }:

{
  home.username = "vinso";
  home.homeDirectory = "/home/vinso";

  home.packages = with pkgs; [
    telegram-desktop
    firefox
    vscode
    (pkgs.discord.override {
      withVencord = true;
    }) 
    spotify
    starship
    alacritty
    neofetch
    android-tools
    nur.repos.pokon548.nekoray-bin
    lutris
    qbittorrent
    wineWowPackages.stable
    mangohud
    protonup-qt
  ];

  programs.git = {
    enable = true;
    userName = "Vinso";
    userEmail = "8vinso8@gmail.com";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set fish_color_normal brcyan
      set fish_color_autosuggestion '#7d7d7d'
      set fish_color_command brcyan
      set fish_color_error '#ff6c6b'
      set fish_color_param brcyan
      function __history_previous_command
        switch (commandline -t)
        case "!"
          commandline -t $history[1]; commandline -f repaint
        case "*"
          commandline -i !
        end
      end
      bind ! __history_previous_command
      alias ..='cd ..'
      starship init fish | source
    '';
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.8;
      scrolling.multiplier = 5;
      cursor = {
        style = { shape = "Beam"; blinking = "On"; };
        blink_interval = 1000;
      };
      colors.primary = {
        background = "#24292e";
        foreground = "#d1d5da";
      };
      colors.normal = {
        black   = "#586069";
        red     = "#ea4a5a";
        green   = "#34d058";
        yellow  = "#ffea7f";
        blue    = "#2188ff";
        magenta = "#b392f0";
        cyan    = "#39c5cf";
        white   = "#d1d5da"; 
      };
      colors.bright = {
        black   = "#959da5";
        red     = "#f97583";
        green   = "#85e89d";
        yellow  = "#ffea7f";
        blue    = "#79b8ff";
        magenta = "#b392f0";
        cyan    = "#56d4dd";
        white   = "#fafbfc";
      };
    };
  };

  xdg.configFile."pipewire/pipewire.conf.d/10-split.conf".text = ''
    context.modules = [
        {   name = libpipewire-module-loopback
            args = {
                node.description = "UMC Microphone"
                capture.props = {
                    node.name = "capture.UMC_Mic"
                    audio.position = [ AUX0 ]
                    stream.dont-remix = true
                    target.object = "alsa_input.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo-input"
                    node.passive = true
                }
                playback.props = {
                    node.name = "UMC_Mic"
                    media.class = "Audio/Source"
                    audio.position = [ MONO ]
                }
            }
        }
        {   name = libpipewire-module-loopback
            args = {
                node.description = "UMC Guitar"
                capture.props = {
                    node.name = "capture.UMC_Guitar"
                    audio.position = [ AUX1 ]
                    stream.dont-remix = true
                    target.object = "alsa_input.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo-input"
                    node.passive = true
                }
                playback.props = {
                    node.name = "UMC_Guitar"
                    media.class = "Audio/Source"
                    audio.position = [ MONO ]
                }
            }
        }
    ]
  '';

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
