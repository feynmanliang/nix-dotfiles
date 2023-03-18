{
  description = "My first nix flake";

  inputs = {
    # Package sets
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";

    # Environment/system management
    darwin.url = "github:LnL7/nix-darwin";
    # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = { self, nixpkgs, darwin, home-manager }: {
    # we want `nix-darwin` and not gnu hello, so the packages stuff can go
  
    darwinConfigurations."darkstar" = darwin.lib.darwinSystem {
    # you can have multiple darwinConfigurations per flake, one per hostname
  
      system = "x86_64-darwin"; # "aarch64-darwin";
      modules = [ 
        ./hosts/darkstar/default.nix 

        # The flake-based setup of the Home Manager `nix-darwin` module
        # https://nix-community.github.io/home-manager/index.html#sec-flakes-nix-darwin-module
        home-manager.darwinModules.home-manager
      ]; # will be important later
    };
  };
}
