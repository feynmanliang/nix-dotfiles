{ pkgs, ... }: 

let
  mypkgs = import ../../mypkgs { nixpkgs = pkgs; };
in
{
    home.stateVersion = "22.11";

    fonts.fontconfig.enable = true;
    home.packages = ([
      (pkgs.nerdfonts.override { fonts = [ "Cousine" ]; })
    ])
    ++ (with mypkgs; [ nvchad ]);

    programs.neovim = import ./nvim.nix { pkgs = pkgs; };
  
    programs.tmux = {
      enable = true;
      shortcut = "a";
      keyMode = "vi";
      plugins = with pkgs.tmuxPlugins; [
        pain-control
        gruvbox
      ];
    };

    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "vi-mode"
        ];
      };
    };
    programs.starship.enable = true;
  }
