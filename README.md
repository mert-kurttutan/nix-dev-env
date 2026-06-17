# nix-dev-env

Reusable Nix development shells for working across repositories that may not have their own `flake.nix`.

Use a shell from any directory with the GitHub flake URL:

```bash
nix develop github:mert-kurttutan/nix-dev-env#compiler-explorer
```

Use the AWS-only shell:

```bash
nix develop github:mert-kurttutan/nix-dev-env#aws
```

If flakes are not enabled by default on the machine:

```bash
nix --extra-experimental-features 'nix-command flakes' develop github:mert-kurttutan/nix-dev-env#compiler-explorer
```
