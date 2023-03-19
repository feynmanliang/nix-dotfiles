{ pkgs }:

let
  pname = "nvchad";
  version = "2.0";

  src = pkgs.fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "8214d4e8589aa6625c6db077b8eb199e7ebc1929";
    sha256 = "1w7RPJ5EXD73pkeJV0mt3daaMHPiRQgtHT/OUErfDi4=";
  };

  launcher = pkgs.writeScript "nvchad" ''
    export PATH="${pkgs.lib.makeBinPath [ 
      pkgs.coreutils 
      pkgs.neovim 
      pkgs.ripgrep 
      pkgs.fd 
      pkgs.ueberzug 
      pkgs.git 
      pkgs.cargo
    ]}"
    export XDG_CONFIG_HOME=$(mktemp -d)

    # FIXME: Use the real XDG_CONFIG_HOME or fallback to $HOME/.config
    mkdir -p $HOME/.config/nvchad

    # Set up a disposable XDG_CONFIG_HOME
    mkdir $XDG_CONFIG_HOME/nvim
    ln -s ${src}/LICENSE $XDG_CONFIG_HOME/nvim/LICENSE
    ln -s ${src}/README.md $XDG_CONFIG_HOME/nvim/README.md
    ln -s ${src}/init.lua $XDG_CONFIG_HOME/nvim/init.lua
    cp -r ${src}/lua $XDG_CONFIG_HOME/nvim/lua
    chmod u+w $XDG_CONFIG_HOME/nvim/lua
    ln -s $HOME/.config/nvchad $XDG_CONFIG_HOME/nvim/lua/custom

    # Copy the initial user configuration, if it doesn't already exist.
    cp -n ${src}/lua/chadrc.lua $HOME/.config/nvchad/

    exec nvim "$@"
  '';
in
pkgs.stdenv.mkDerivation rec {
  inherit src version pname;

  postPatch = pkgs.lib.optionalString pkgs.stdenv.isDarwin ''
    # Fake the impure dependencies pbpaste and pbcopy
    mkdir bin
    echo '#!${pkgs.stdenv.shell}' > bin/pbpaste
    echo '#!${pkgs.stdenv.shell}' > bin/pbcopy
    chmod +x bin/{pbcopy,pbpaste}
    export PATH=$(realpath bin):$PATH
  '';

  installPhase = ''
    mkdir -p $out/bin
    ln -s ${launcher} $out/bin/nvchad
  '';
}
