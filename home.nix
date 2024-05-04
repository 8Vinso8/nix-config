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
    alacritty
    fastfetch
    android-tools
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
    unrar
    libsecret
    spotify
    protontricks
    nix-prefetch-github
    killall
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  #Use this to store spotify credentials
  # secret-tool store --label='name you choose' application rust-keyring service spotifyd username <your-username>
  # services.spotifyd = {
  #   enable = true;
  #   package = (pkgs.spotifyd.override {
  #     withKeyring = true; 
  #     withMpris = true;
  #     withPulseAudio = true;
  #   });
  #   settings = {
  #     global = {
  #       username = "p2xr5csvoc430v7bklao1mfa6";
  #       use_keyring = true;
  #       backend = "pulseaudio";
  #       device_name = "spotifyd";
  #       device_type = "computer";
  #       bitrate = 320;
  #       use_mpris = true;
  #       dbus_type = "session";
  #       volume_normalisation = false;
  #       autoplay = true;
  #     };
  #   };
  # };

  home.file."wallpapers/wall1.png".source = ./wallpapers/wallpaper.png;

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
      };
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    size = 24;
    name = "phinger-cursors-dark";
    package =  pkgs.phinger-cursors;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
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

  home.file.".local/share/Steam/steam_dev.cfg".text = ''
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
