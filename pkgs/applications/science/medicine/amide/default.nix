{ lib
, stdenv
, fetchzip
, m4
, pkg-config
, intltool
, which
, libxslt
, gtk2
, libxml2
, libgnomecanvas
, GConf
, gnome_vfs
, gnome-doc-utils
, xmedcon-gtk2
, dcmtk
, volpack
, ffmpeg
, gsl_1
}:

let
  ffmpeg28 = (ffmpeg.override rec {
    version = "2.8.20";
    branch = version;
    sha256 = "sha256-4sdYAUnw7VAJf8XkFgOXW4Pf52iXchljbKF+g9Jc2ho=";
  }).overrideDerivation (prev: {
    configureFlags = lib.remove "--enable-libzimg" prev.configureFlags;
    doCheck = false;
  });
in stdenv.mkDerivation rec {
  pname = "amide";
  version = "1.0.5";

  src = fetchzip {
    url = "mirror://sourceforge/project/amide/amide/${version}/amide-${version}.tgz";
    sha256 = "sha256-MKoVSoSwGGnHzjZESlhchBLmffVNHsdLWW0sDFwAlRA=";
  };

  nativeBuildInputs = [ m4 pkg-config intltool which libxslt ];

  buildInputs = [
    gtk2
    libxml2
    libgnomecanvas
    GConf
    gnome_vfs
    gnome-doc-utils
    xmedcon-gtk2
    dcmtk
    volpack
    ffmpeg28
    gsl_1
  ];

  patches = [
    # Fixes an if clause that was using deprecated syntax.
    ./fix-isinf-clause.patch
  ];

  # Disable deprecated doc system
  configureFlags = [
    "--disable-scrollkeeper"
  ];

  makeFlags = [
    "LDFLAGS=-zmuldefs"
  ];

  dontStrip = true;
}
