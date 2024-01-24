{ stdenv
, cmake
, boost
, gbenchmark
, fetchurl
}:

stdenv.mkDerivation rec {
  pname = "microbench_test";
  version = "0.0.2";

  src = fetchurl {
    url = "https://github.com/krupkat/${pname}/archive/refs/tags/${version}.tar.gz";
    sha256 = "0gzzi3bg4yrlcmimjib2hz6r5djk5v3y7a0azcpypch90a9f2k1i";
  };

  nativeBuildInputs = [ 
    cmake
  ];

  # can be used at build time and run time
  buildInputs = [
    boost
    gbenchmark
  ];
}
