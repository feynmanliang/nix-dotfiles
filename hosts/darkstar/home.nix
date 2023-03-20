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

    imports = [
        ./git.nix
        ./nvim/nvim.nix
        ./tmux.nix
        ./zsh.nix
    ];
  }
