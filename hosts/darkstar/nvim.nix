{ pkgs, ... }:

{
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        plugins = with pkgs.vimPlugins; [ 
            plenary-nvim
            gruvbox-material
            vim-nix
            {
                plugin = nvim-tree-lua;
                config = "lua require('nvim-tree').setup()";
            }
            nvim-web-devicons
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
        extraLuaConfig = builtins.readFile ./init.lua;
    };
}
