{ pkgs }:

let
  common = import ./common.nix { inherit pkgs; };
in
pkgs.mkShell {
  packages = common.packages ++ (with pkgs; [
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
  '';
}
