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
      mkShell = file: import file { inherit pkgs; };
    in {
      devShells.${system} = {
        default = (mkShell ./shells/common.nix).shell;
        compiler-explorer = mkShell ./shells/compiler-explorer.nix;
        compiler-explorer-infra = mkShell ./shells/compiler-explorer-infra.nix;
        aws = mkShell ./shells/aws.nix;
      };

      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
