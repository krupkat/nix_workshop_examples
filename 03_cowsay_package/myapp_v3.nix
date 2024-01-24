{ stdenv
, python3
, cowsay
, makeWrapper
, lib
, writeShellApplication
, curl
, jq
, verbose ? false
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

  installPhase =
    let
      client = writeShellApplication {
        name = "nixcow";
        runtimeInputs = [ curl jq ];
        text = ''
          curl 127.0.0.1:5000 ${lib.optionalString (!verbose) "-s"} | jq -r '.message'
        '';
      };
    in
    ''
      install -m755 -D ${./myapp.py} $out/bin/cowsayer-server
      wrapProgram $out/bin/cowsayer-server \
        --prefix PATH : ${lib.makeBinPath [ cowsay ]}

      ln -s ${lib.getExe client} $out/bin/nixcow
    '';
}
