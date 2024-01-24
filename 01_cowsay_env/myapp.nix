{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (ps: [ ps.flask ]))
    pkgs.curl
    pkgs.jq
  ];
}
