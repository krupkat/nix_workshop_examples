let
  pkgs = import <nixpkgs> { crossSystem = { config = "aarch64-unknown-linux-gnu"; }; };
in

pkgs.callPackage ../04_benchmark/bench.nix {}
