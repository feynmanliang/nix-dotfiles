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

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [ 
          vim-nix
          plenary-nvim
          gruvbox-material
          {
              plugin = impatient-nvim;
              config = "lua require('impatient')";
          }
          {
              plugin = lualine-nvim;
              config = "lua require('lualine').setup()";
          }
          {
              plugin = telescope-nvim;
              config = "lua require('telescope').setup()";
          }
          {
              plugin = indent-blankline-nvim;
              config = "lua require('indent_blankline').setup()";
          }
          {
              plugin = nvim-lspconfig;
              config = ''
                  lua << EOF
                  require('lspconfig').rust_analyzer.setup{}
                  require('lspconfig').sumneko_lua.setup{}
                  require('lspconfig').rnix.setup{}
                  require('lspconfig').zk.setup{}
                  EOF
              '';
          }
          {
              plugin = nvim-treesitter;
              config = ''
              lua << EOF
              require('nvim-treesitter.configs').setup {
                  highlight = {
                      enable = true,
                      additional_vim_regex_highlighting = false,
                  },
              }
              EOF
              '';
          }
      ];
    };
  
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
