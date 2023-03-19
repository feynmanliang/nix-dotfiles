{ pkgs }:

{
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
  extraLuaConfig = ''
    local o = vim.opt
    local g = vim.g
    
    -- Autocmds
    vim.cmd [[
    augroup CursorLine
        au!
        au VimEnter * setlocal cursorline
        au WinEnter * setlocal cursorline
        au BufWinEnter * setlocal cursorline
        au WinLeave * setlocal nocursorline
    augroup END
    autocmd FileType nix setlocal shiftwidth=4
    ]]
    
    -- Keybinds
    local map = vim.api.nvim_set_keymap
    local opts = { silent = true, noremap = true }
    
    map("n", "<C-n>", ":NvimTreeToggle <CR>", opts)
    map('n', '<C-l>', ':Telescope live_grep <CR>', opts)
    map('n', '<C-p>', ':Telescope find_files <CR>', opts)
    map('n', 'j', 'gj', opts)
    map('n', 'k', 'gk', opts)
    map('n', ';', ':', { noremap = true } )
    
    g.mapleader = ' '
    
    -- Performance
    o.lazyredraw = true;
    o.shell = "zsh"
    o.shadafile = "NONE"
    
    -- Colors
    vim.cmd.colorscheme("gruvbox-material")
    o.termguicolors = true
    
    -- Undo files
    o.undofile = true
    
    -- Indentation
    o.smartindent = true
    o.tabstop = 4
    o.shiftwidth = 4
    o.shiftround = true
    o.expandtab = true
    o.scrolloff = 3
    
    -- Set clipboard to use system clipboard
    o.clipboard = "unnamedplus"
    
    -- Use mouse
    o.mouse = "a"
    
    -- Nicer UI settings
    o.cursorline = true
    o.relativenumber = true
    o.number = true
    
    -- Get rid of annoying viminfo file
    o.viminfo = ""
    o.viminfofile = "NONE"
    
    -- Miscellaneous quality of life
    o.ignorecase = true
    o.ttimeoutlen = 5
    o.hidden = true
    o.shortmess = "atI"
    o.wrap = false
    o.backup = false
    o.writebackup = false
    o.errorbells = false
    o.swapfile = false
    o.showmode = false
    o.laststatus = 3
    o.pumheight = 6
    o.splitright = true
    o.splitbelow = true
    o.completeopt = "menuone,noselect"
  '';
}
