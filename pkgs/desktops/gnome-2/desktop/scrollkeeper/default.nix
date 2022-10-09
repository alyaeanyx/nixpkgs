{ lib, stdenv, fetchurl, pkg-config, perlPackages, libxml2, libxslt, docbook_xml_dtd_42, automake, gettext }:

let
  libxml2_29 = libxml2.overrideDerivation (prev: rec {
    version = "2.9.14";
    src = fetchurl {
      url = "mirror://gnome/sources/${prev.pname}/${lib.versions.majorMinor version}/${prev.pname}-${version}.tar.xz";
      sha256 = "1vnzk33wfms348lgz9pvkq9li7jm44pvm73lbr3w1khwgljlmmv0";
    };
  });
in stdenv.mkDerivation rec {
  pname = "scrollkeeper";
  version = "0.3.14";

  src = fetchurl {
    url = "mirror://gnome/sources/scrollkeeper/${lib.versions.majorMinor version}/scrollkeeper-${version}.tar.bz2";
    sha256 = "08n1xgj1f53zahwm0wpn3jid3rfbhi3iwby0ilaaldnid5qriqgc";
  };

  # The fuloong2f is not supported by scrollkeeper-0.3.14 config.guess
  preConfigure = "
    substituteInPlace extract/dtds/Makefile.am --replace /usr/bin/xmlcatalog xmlcatalog
    cp ${automake}/share/automake*/config.{sub,guess} .
  ";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libxml2_29 libxslt gettext ]
    ++ (with perlPackages; [ perl XMLParser ]);
  configureFlags = [ "--with-xml-catalog=${docbook_xml_dtd_42}/xml/dtd/docbook/catalog.xml" ];
}
