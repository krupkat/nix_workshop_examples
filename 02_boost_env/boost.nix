{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; 
    let 
      myPython = python3.withPackages (ps: [ ps.matplotlib ps.numpy ]);
    in
  [
    (boost.override {
      enablePython = true;
      enableNumpy = true;
      python = myPython;
    })
    myPython
    cmake
  ];
}
