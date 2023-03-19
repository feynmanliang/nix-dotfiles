{ pkgs, ... }: 

let
  mypkgs = import ../../mypkgs { nixpkgs = pkgs; };
in
  {
    home.stateVersion = "22.11";

    fonts.fontconfig.enable = true;
    home.packages = (with pkgs; [
      (nerdfonts.override { fonts = [ "Cousine" ]; })
      htop
      httpie
      jq
      yq
      ripgrep

      # nix
      rnix-lsp 
      nixfmt

      # lua
      sumneko-lua-language-server 
      stylua
    ])
    ++ (with mypkgs; [ nvchad ]);

    programs.git = import ./git.nix { };

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
      plugins = [
        {
          name = "alias-tips";
          src = pkgs.fetchFromGitHub {
            owner = "djui";
            repo = "alias-tips";
            rev = "41cb143ccc3b8cc444bf20257276cb43275f65c4";
            sha256 = "ZFWrwcwwwSYP5d8k7Lr/hL3WKAZmgn51Q9hYL3bq9vE=";
          };
        }
      ];
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
