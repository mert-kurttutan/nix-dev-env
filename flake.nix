{
  description = "Reusable development shells";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";
  };

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate =
          pkg: builtins.elem (nixpkgs.lib.getName pkg) [ "packer" ];
      };
      sfpi = pkgs.callPackage ./nix/sfpi.nix { };
    in {
      devShells.${system} = {
        default = (import ./shells/common.nix { inherit pkgs; }).shell;
        compiler-explorer = import ./shells/compiler-explorer.nix { inherit pkgs; };
        compiler-explorer-infra = import ./shells/compiler-explorer-infra.nix { inherit pkgs; };
        aws = import ./shells/aws.nix { inherit pkgs; };
        tt-metal = import ./shells/tt-metal.nix { inherit pkgs sfpi; };
      };

      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
