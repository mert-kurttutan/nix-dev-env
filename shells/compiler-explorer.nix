{ pkgs }:

let
  common = import ./common.nix { inherit pkgs; };
in
pkgs.mkShell {
  packages = common.packages ++ (with pkgs; [
    fnm
    gcc
    gnumake
    pkg-config
    python3
    vitejs
  ]);

  shellHook = ''
    export PATH="$PWD/node_modules/.bin:$PATH"
  '';
}
