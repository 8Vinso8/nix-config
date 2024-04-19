{ config, pkgs, inputs, ... }:

{
  imports = [
    ./configs
  ];
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
    alacritty
    neofetch
    android-tools
    lutris
    qbittorrent
    wineWowPackages.stable
    mangohud
    protonup-qt
    nekoray
    wofi
    libsForQt5.polkit-kde-agent
    inputs.hyprland-contrib.packages."${pkgs.system}".grimblast
    hyprlock
    hypridle
    hyprpaper
    waybar
    ddcutil
    pavucontrol
    pamixer
    playerctl
    dunst
    uget
  ];

  home.pointerCursor = {
    gtk.enable = true;
    size = 24;
    name = "Adwaita";
    package =  pkgs.gnome.adwaita-icon-theme;
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };

  programs.git = {
    enable = true;
    userName = "Vinso";
    userEmail = "8vinso8@gmail.com";
  };

  home.file.".steam/steam/steam_dev.cfg".text = ''
    @nClientDownloadEnableHTTP2PlatformLinux 0
    @fDownloadRateImprovementToAddAnotherConnection 1.0
  '';

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
