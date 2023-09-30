{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    initrd = {
      kernelModules = [ "amdgpu" "zstd" "z3fold" ];
      preDeviceCommands = ''
        printf zstd > /sys/module/zswap/parameters/compressor
        printf z3fold > /sys/module/zswap/parameters/zpool
      '';
      verbose = false;
    };
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "amd_pstate=passive"
      "zswap.enabled=1"
    ];
    plymouth = {
      enable = true;
      theme = "breeze";
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16*1024;
    }
  ];

  hardware.bluetooth.enable = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.checkReversePath = false;
  };

  services.resolved.enable = true;

  time.timeZone = "Asia/Vladivostok";

  i18n.defaultLocale = "ru_RU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  users.users.vinso = {
    isNormalUser = true;
    description = "vinso";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    shell = pkgs.fish;
    packages = with pkgs; [];
  };

  security.sudo.wheelNeedsPassword = false;
  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if ((action.id == "org.corectrl.helper.init" ||
          action.id == "org.corectrl.helperkiller.init") &&
          subject.local == true &&
          subject.active == true &&
          subject.isInGroup("wheel")) {
            return polkit.Result.YES;
        }
      });
    '';
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    git
    xdg-utils
    vscode
    firefox
    pavucontrol
    (discord.override {withVencord = true;})
    spotify
    starship
    telegram-desktop
    android-tools
    neofetch
    protontricks
    google-chrome
    gnome3.gnome-tweaks
    wineWowPackages.stable
    winetricks
    lutris
  ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    gedit
    epiphany
    geary
    evince
    gnome-characters
    totem
    tali
    iagno
    hitori
    atomix
  ]);

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      fira-code
      ubuntu_font_family
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["Ubuntu"];
        sansSerif = ["Ubuntu"];
        monospace = ["Ubuntu Mono"];
      };
    };
  };

  services.xserver = {
    enable = true;
    displayManager = {
      sddm = {
        enable = true;
      };
    };
    desktopManager.plasma5 = {
      enable = true;
    };
  };

  systemd.services.BiosSleepFix = {
    enable = true;
    description = "Gigabyte B550 F12 bios sleep bug workaround";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/bin/sh -c 'echo GPP0 > /proc/acpi/wakeup'";
    };
  };

  programs.fish.enable = true;
  environment.shells = with pkgs; [ fish ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.dconf.enable = true;

  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };

  system.stateVersion = "23.05";
}
