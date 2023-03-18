{
  description = "My first nix flake";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
      # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
      darwin.url = "github:lnl7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "nixpkgs"; # ...
  };
  
  outputs = { self, nixpkgs, home-manager, darwin }: {
    # we want `nix-darwin` and not gnu hello, so the packages stuff can go
  
    darwinConfigurations."darkstar" = darwin.lib.darwinSystem {
    # you can have multiple darwinConfigurations per flake, one per hostname
  
      system = "x86_64-darwin"; # "aarch64-darwin";
      modules = [ 
        home-manager.darwinModules.home-manager
        ./hosts/darkstar/default.nix 
      ]; # will be important later
    };
  };
}
