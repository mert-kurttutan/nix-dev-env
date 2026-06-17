{ pkgs }:

let
  common = import ./common.nix { inherit pkgs; };
  sfpiLibs = with pkgs; [
    gmp
    libmpc
    mpfr
    zlib
    zstd
  ];
in
pkgs.mkShell {
  packages = common.packages ++ sfpiLibs ++ (with pkgs; [
    awscli2
    gcc
    gnumake
    nodePackages.npm
    nodePackages.typescript
    nodePackages.vite
    nodePackages.wrangler
    nodejs_22
    pkg-config
    python3
  ]);

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath sfpiLibs}:$LD_LIBRARY_PATH
  '';
}
