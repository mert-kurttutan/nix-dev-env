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
    nodejs_22
    pkg-config
    python3
    vitejs
    wrangler
  ]);

  shellHook = ''
    export PATH="$PWD/node_modules/.bin:$PATH"
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath sfpiLibs}:$LD_LIBRARY_PATH
  '';
}
