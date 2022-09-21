{ lib
, buildPythonPackage
, fetchFromGitHub
, cryptography
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "cryptography-fernet-wrapper";
  version = "1.0.3";

  src = fetchFromGitHub {
    owner = "i10b";
    repo = "python-cryptography-fernet-wrapper";
    rev = "v${version}";
    sha256 = "sha256-84KUE3yjuKggolQGzrhBGOb7wCXbG71NC8cAJU7RKO8=";
  };

  propagatedBuildInputs = [
    cryptography
  ];

  preBuild = ''
    # make the build script happy
    touch README.md
  '';

  pythonImportsCheck = [ "fernet_wrapper" ];

  meta = with lib; {
    description = "Fernet wrapper for the Python cryptography module";
    homepage = "https://github.com/i10b/python-cryptography-fernet-wrapper";
    license = [ licenses.gpl3 ];
    maintainers = with maintainers; [ alyaeanyx ];
  };
}
