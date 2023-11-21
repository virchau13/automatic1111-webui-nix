{ variant ? "NONE" }:

let pkgs = import <nixpkgs> { };
in import ./impl.nix { inherit pkgs variant; }
