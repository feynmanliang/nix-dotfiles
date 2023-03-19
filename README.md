Set up local flake.
```bash
nix build .#darwinConfigurations.darkstar.system
```

Rebuild and load changes.
```bash
./result/sw/bin/darwin-rebuild switch --flake .#darkstar
```
