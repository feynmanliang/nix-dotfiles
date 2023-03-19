
```bash
nix build .#darwinConfigurations.darkstar.system
./result/sw/bin/darwin-rebuild switch --flake .#darkstar
```
