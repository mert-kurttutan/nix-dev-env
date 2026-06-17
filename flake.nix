{
  description = "Reusable development shells";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      mkShell = file: import file { inherit pkgs; };
    in {
      devShells.${system} = {
        default = (mkShell ./shells/common.nix).shell;
        compiler-explorer = mkShell ./shells/compiler-explorer.nix;
        aws = mkShell ./shells/aws.nix;
      };
    };
}
