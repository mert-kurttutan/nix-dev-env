{
  fetchurl,
  runCommand,
  autoPatchelfHook,
  ncurses,
  isl_0_23,
  mpfr,
  libmpc,
  xz,
  zstd,
  expat,
}:

runCommand "sfpi-7.72.0" {
  version = "7.72.0";

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    ncurses
    isl_0_23
    mpfr
    libmpc
    xz
    zstd
    expat
  ];

  src = fetchurl {
    url = "https://github.com/tenstorrent/sfpi/releases/download/7.72.0/sfpi_7.72.0_x86_64_debian.txz";
    sha256 = "804aec3ed9e3ad88e8ed60ca6f54d99852148cf49fe2d360324e560402437758";
  };
} ''
  runPhase unpackPhase
  mkdir -p "$out"
  cp -r ../"$sourceRoot" "$out/sfpi"
  runPhase fixupPhase
''
