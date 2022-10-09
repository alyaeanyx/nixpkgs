{ lib, stdenv, fetchzip, m4 }:

stdenv.mkDerivation rec {
  pname = "volpack";
  version = "1.0c7";

  src = fetchzip {
    url = "mirror://sourceforge/project/amide/volpack/${version}/volpack-${version}.tgz";
    sha256 = "sha256-I+r+K5CvMAga9LHO5e5c4JkyNP4Jn9irGqg1mcsYKc4=";
  };

  nativeBuildInputs = [ m4 ];

  meta = with lib; {
    description = "Portable software library for volume rendering. Linux/macOS port from the AMIDE project.";
    homepage = "http://graphics.stanford.edu/software/volpack/";
    license = with lib.licenses; [ bsd3 ];
    maintainers = with lib.maintainers; [ alyaeanyx ];
    platforms = lib.platforms.unix;
  };
}
