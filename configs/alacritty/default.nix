{ config, pkgs, ... }:

{
  xdg.configFile."alacritty/themes" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "alacritty";
      repo = "alacritty-theme";
      rev = "94e1dc0b9511969a426208fbba24bd7448493785";
      sha256 = "bPup3AKFGVuUC8CzVhWJPKphHdx0GAc62GxWsUWQ7Xk=";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "~/.config/alacritty/themes/themes/catppuccin_mocha.toml"
      ];
      env = {
        TERM = "xterm-256color";
      };
      window = {
        decorations = "None";
      };
      scrolling = {
        multiplier = 5;
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
        thickness = 0.25;
      };
      font = {
        size = 16;
        normal = {
          family = "UbuntuMono Nerd Font";
          style = "Regular";
        };
      };
    };
  };
}
