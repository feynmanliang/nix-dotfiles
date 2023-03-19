{ pkgs, ... }:

let
  mypkgs = import ../../mypkgs { nixpkgs = pkgs; };
in
{
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  
  # if you use zsh (the default on new macOS installations),
  # you'll need to enable this so nix-darwin creates a zshrc sourcing needed environment changes
  programs.zsh.enable = true;
  # bash is enabled by default

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    # updates homebrew packages on activation,
    # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
    casks = [
      "amethyst"
      "alfred"
      "discord"
    ];
  };

  users.users.feynman = {
    name = "feynman";
    home = "/Users/feynman";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.feynman = { pkgs, ... }: {
  
    home.stateVersion = "22.11";

    fonts.fontconfig.enable = true;
    home.packages = ([
      (pkgs.nerdfonts.override { fonts = [ "Cousine" ]; })
    ])
    ++ (with mypkgs; [ nvchad ]);

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        plenary-nvim
        gruvbox-material
        mini-nvim
      ];
    };
  
    programs.tmux = {
      enable = true;
      shortcut = "a";
      keyMode = "vi";
      # plugins = with pkgs.tmuxPlugins; [
      #   pain-control
      #   gruvbox
      # ];
    };

    programs.zsh.enable = true;
    programs.starship.enable = true;
  };
}
