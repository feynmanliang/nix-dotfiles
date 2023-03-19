{ pkgs, ... }: 

let
  mypkgs = import ../../mypkgs { nixpkgs = pkgs; };
in
{
    home.stateVersion = "22.11";

    fonts.fontconfig.enable = true;
    home.packages = (with pkgs; [
      (nerdfonts.override { fonts = [ "Cousine" ]; })
      htop httpie jq yq
      # TODO: package with neovim
      ripgrep
      rnix-lsp nixfmt
      sumneko-lua-language-server stylua # Lua
    ])
    ++ (with mypkgs; [ nvchad ]);

    programs.git = {
      enable = true;
      userEmail = "feynman.liang@gmail.com";
      userName = "Feynman Liang";
    };

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
