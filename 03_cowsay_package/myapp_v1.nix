{ stdenv
, python3
}:

stdenv.mkDerivation rec {
  pname = "cowsayer";
  version = "0.0.1";

  src = [
    ./myapp.py
  ];

  dontUnpack = true;

  # can be used at build time only
  nativeBuildInputs = [ ];

  # can be used at build time and run time
  buildInputs = [
    (python3.withPackages (ps: [ ps.flask ]))
  ];

  buildPhase = ''
    sleep 1
  '';

  installPhase = ''
    install -m755 -D ${./myapp.py} $out/bin/cowsayer-server
  '';
}
