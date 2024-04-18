{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 16*1024;
  } ];

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
      kernelModules = [ "amdgpu" "zstd" "z3fold" "i2c-dev" ];
      preDeviceCommands = ''
        printf zstd > /sys/module/zswap/parameters/compressor
        printf z3fold > /sys/module/zswap/parameters/zpool
      '';
      verbose = false;
    };
    extraModulePackages = with config.boot.kernelPackages; [];
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
    kernelPackages = pkgs.linuxPackages;
  };

  hardware.opengl.driSupport32Bit = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.checkReversePath = false;
  };
  services.resolved.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  time.timeZone = "Asia/Vladivostok";

  i18n.defaultLocale = "ru_RU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;
  # services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  programs.hyprland.enable = true;


  systemd.services.BiosSleepFix = {
    enable = true;
    description = "Gigabyte B550 F12 bios sleep bug workaround";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/bin/sh -c 'echo GPP0 > /proc/acpi/wakeup'";
    };
  };

  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };

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

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.gamemode.enable = true;

  programs.fish.enable = true;
  programs.dconf.enable = true;

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      fira-code
      ubuntu_font_family
    ];
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  users.users.vinso = {
    isNormalUser = true;
    description = "Vinso";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [ 
    git
  ];

  system.stateVersion = "23.11";
}
