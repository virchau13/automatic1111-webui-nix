pkgs:

pkgs.mkShell rec {
    name = "stable-diffusion-webui";
    buildInputs = with pkgs; [
        git # The program instantly crashes if git is not present, even if everything is already downloaded
        python310
        stdenv.cc.cc.lib
        stdenv.cc
        ncurses5
        binutils
        gitRepo gnupg autoconf curl
        procps gnumake util-linux m4 gperf unzip
        cudatoolkit linuxPackages.nvidia_x11
        libGLU libGL
        xorg.libXi xorg.libXmu freeglut
        xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib
        glib
    ];
    shellHook = ''
        export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath buildInputs}"
        export CUDA_PATH=${pkgs.cudatoolkit}
        export EXTRA_LDFLAGS="-L${pkgs.linuxPackages.nvidia_x11}/lib"
    '';
}
