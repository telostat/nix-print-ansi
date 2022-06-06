{ pkgs ? import (fetchTarball https://github.com/NixOS/nixpkgs/archive/22.05.tar.gz) { }
, ...
}:

let
  ## Get reference to ansi:
  ansi = fetchTarball https://github.com/fidian/ansi/archive/3.0.1.tar.gz;

  ## Package name:
  name = "nix-print-ansi";

  ## Package version:
  version = "3.0.1";
in
pkgs.stdenv.mkDerivation {
  pname = name;
  version = version;

  src = ./.;

  buildInputs = [
    pkgs.bash
  ];

  nativeBuildInputs = [
    pkgs.makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${ansi}/ansi $out/bin/ansi
    wrapProgram $out/bin/ansi
  '';
}
