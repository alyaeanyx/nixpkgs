{ stdenv
, lib
, fetchurl
, gtk2
, gtk3
, glib
, pkg-config
, libpng
, zlib
, useGtk2 ? false
}:

stdenv.mkDerivation rec {
  pname = "xmedcon";
  version = "0.22.0${lib.optionalString useGtk2 "-gtk2"}";

  src = fetchurl {
    url = "mirror://sourceforge/${pname}/${pname}-${version}.tar.bz2";
    sha256 = if useGtk2 then "sha256-53UHrdq0hpWsUjkef7BCU4uVfsrrKAyhi6aeBxHOzS0=" else "sha256-Ui7XoLSzTMPIFW/3nARCmvlGF+1l7pmcnKsnvn3NFJE=";
  };

  buildInputs = [
    glib
    libpng
    zlib
  ] ++ (if useGtk2 then [ gtk2 ] else [ gtk3 ]);

  nativeBuildInputs = [ pkg-config ];

  meta = with lib; {
    description = "An open source toolkit for medical image conversion ";
    homepage = "https://xmedcon.sourceforge.io/Main/HomePage";
    license = licenses.lgpl2Plus;
    maintainers = with maintainers; [ arianvp flokli ];
    platforms = platforms.darwin ++ platforms.linux;
  };
}
