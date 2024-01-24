{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/5f5210aa20e343b7e35f40c033000db0ef80d7b9.tar.gz") {}
}:

pkgs.mkShell {
  packages = [
    pkgs.vlc
  ];
}
