{ pkgs }:

let
  common = import ./common.nix { inherit pkgs; };

  # Compiler Explorer infra's terraform/main.tf requires ~> 1.11.4.
  terraform = pkgs.stdenvNoCC.mkDerivation {
    pname = "terraform";
    version = "1.11.4";

    src = pkgs.fetchurl {
      url = "https://releases.hashicorp.com/terraform/1.11.4/terraform_1.11.4_linux_amd64.zip";
      sha256 = "1ce994251c00281d6845f0f268637ba50c0005657eb3cf096b92f753b42ef4dc";
    };

    nativeBuildInputs = [ pkgs.unzip ];
    sourceRoot = ".";
    dontBuild = true;

    installPhase = ''
      runHook preInstall
      install -Dm755 terraform "$out/bin/terraform"
      runHook postInstall
    '';
  };
in
pkgs.mkShell {
  packages = common.packages ++ [
    pkgs.python312
    pkgs.uv
    pkgs.nodejs_22

    terraform
    pkgs.packer
    pkgs.awscli2

    pkgs.gh
    pkgs.gnumake
    pkgs.jq
    pkgs.yq-go
    pkgs.shellcheck
    pkgs.openssh
    pkgs.rsync
    pkgs.zip
    pkgs.unzip

    pkgs.pkg-config
    pkgs.cairo
    pkgs.libffi
    pkgs.squashfsTools
    pkgs.sshfs
  ];

  shellHook = ''
    export UV_PYTHON="${pkgs.python312}/bin/python3.12"
    export PYTHONPATH="$PWD/bin''${PYTHONPATH:+:$PYTHONPATH}"

    echo "Compiler Explorer infra development shell"
    echo "Python $(python --version 2>&1), Node $(node --version), Terraform $(terraform version -json | jq -r .terraform_version)"
    echo "Run 'make ce' once, then use 'make test' or 'make static-checks'."
  '';
}
