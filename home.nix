{ config, pkgs, ... }:

{
  home.username = "vinso";
  home.homeDirectory = "/home/vinso";

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

  home.packages = with pkgs; [];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
