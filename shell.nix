{ variant ? "CUDA" }:

let pkgs = import <nixpkgs> { };
in import ./impl.nix { inherit pkgs variant; }
