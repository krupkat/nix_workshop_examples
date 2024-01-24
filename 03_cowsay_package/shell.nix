{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  packages = [
    (pkgs.callPackage ./myapp_v1.nix {})
  ];
}
