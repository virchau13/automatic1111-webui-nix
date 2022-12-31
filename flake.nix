{
    description = "AUTOMATIC1111/stable-diffusion-webui flake";

    inputs = {
        nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
        flake-utils.url = github:numtide/flake-utils;
    };

    outputs = { self, nixpkgs, flake-utils }: let
        isLinux = system: builtins.match ".*linux.*" system != null;
        linuxSystems = builtins.filter isLinux flake-utils.lib.defaultSystems;
    in flake-utils.lib.eachSystem linuxSystems (system: let
            pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
            };
        in { 
            devShells.default = import ./impl.nix pkgs;
        }
    );
}
