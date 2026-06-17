{ pkgs }:

let
  packages = with pkgs; [
    curl
    git
    nushell
    ripgrep
  ];
in {
  inherit packages;

  shell = pkgs.mkShell {
    inherit packages;
  };
}
