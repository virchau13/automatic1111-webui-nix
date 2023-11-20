{
    description = "AUTOMATIC1111/stable-diffusion-webui flake";

    inputs = {
        nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
        flake-utils.url = github:numtide/flake-utils;
    };

    outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem flake-utils.lib.defaultSystems (system: let
            pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
            };
        in {
            devShells.default = import ./impl.nix { inherit pkgs; variant = "CPU"; };
            devShells.cuda = import ./impl.nix { inherit pkgs; variant = "CUDA"; };
            devShells.rocm = import ./impl.nix { inherit pkgs; variant = "ROCM"; };
        }
    );
}
