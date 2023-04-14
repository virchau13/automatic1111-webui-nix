{ isCUDA ? true }:

let pkgs = import <nixpkgs> { };
in import ./impl.nix { inherit pkgs isCUDA; }
