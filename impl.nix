{ pkgs, variant, ... }:

let
  hardware_deps = with pkgs;
    if variant == "CUDA" then [
      cudatoolkit
      linuxPackages.nvidia_x11
      xorg.libXi
      xorg.libXmu
      freeglut
      xorg.libXext
      xorg.libX11
      xorg.libXv
      xorg.libXrandr
      zlib

      # for xformers
      gcc
    ] else if variant == "ROCM" then [
      rocmPackages.rocm-runtime
      pciutils
    ] else if variant == "CPU" then [
    ] else throw "You need to specify which variant you want: CPU, ROCm, or CUDA.";

in
pkgs.mkShell rec {
    name = "stable-diffusion-webui";
    buildInputs = with pkgs;
      hardware_deps ++ [
        git # The program instantly crashes if git is not present, even if everything is already downloaded
        python310
        stdenv.cc.cc.lib
        stdenv.cc
        ncurses5
        binutils
        gitRepo gnupg autoconf curl
        procps gnumake util-linux m4 gperf unzip
        libGLU libGL
        glib
      ];
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
    CUDA_PATH = pkgs.lib.optionalString (variant == "CUDA") pkgs.cudatoolkit;
    EXTRA_LDFLAGS = pkgs.lib.optionalString (variant == "CUDA") "-L${pkgs.linuxPackages.nvidia_x11}/lib";
}
