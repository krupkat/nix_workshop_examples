{ pkgs ? import <nixpkgs> { }
, lib ? pkgs.lib
}:

let
  args = lib.cartesianProductOfSets {
    cxxstd = [ "11" "20" ];
    stdenv = [ pkgs.gcc13Stdenv pkgs.llvmPackages_17.stdenv ];
  };

  overrideBoost = { cxxstd, stdenv }: {
    name = "std${cxxstd}-${stdenv.cc.name}";
    stdenv = stdenv;
    boost = pkgs.boost.override {
      extraB2Args = [ "cxxstd=${cxxstd}" ];
      stdenv = stdenv;
    };
  };

  boostList = map overrideBoost args;

  customizeBench = { name, stdenv, boost }:
    pkgs.writeShellApplication {
      name = "bench-${name}";
      runtimeInputs =
        let
          test = pkgs.callPackage ./bench.nix {
            inherit stdenv boost;
          };
        in
        [
          (test.overrideAttrs
            (final: prev: {
              preConfigure = ''
                substituteInPlace benchmark.cc --replace "10000" "1000000"
              '';
            }))
        ];
      text = "bench";
    };
in

pkgs.mkShell rec {
  packages = map customizeBench boostList;

  shellHook =
    let
      runTest = test: ''
        echo "Running ${test.name}:"
        ${test.name}
      '';
    in
    lib.concatMapStringsSep "\n" runTest packages;
}
