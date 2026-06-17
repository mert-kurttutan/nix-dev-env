{ pkgs }:

let
  common = import ./common.nix { inherit pkgs; };
in
pkgs.mkShell {
  packages = common.packages ++ (with pkgs; [
    awscli2
  ]);
}
