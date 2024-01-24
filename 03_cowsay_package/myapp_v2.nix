{ stdenv
, python3
, cowsay
, makeWrapper
, lib
}:

stdenv.mkDerivation rec {
  pname = "cowsayer";
  version = "0.0.2";

  src = [
    ./myapp.py
  ];

  dontUnpack = true;

  # can be used at build time only
  nativeBuildInputs = [
    makeWrapper
  ];

  # can be used at build time and run time
  buildInputs = [
    (python3.withPackages (ps: [ ps.flask ]))
  ];

  buildPhase = ''
    sleep 1
  '';

  installPhase = ''
    install -m755 -D ${./myapp.py} $out/bin/cowsayer-server
    wrapProgram $out/bin/cowsayer-server \
      --prefix PATH : ${lib.makeBinPath [ cowsay ]}
  '';
}
