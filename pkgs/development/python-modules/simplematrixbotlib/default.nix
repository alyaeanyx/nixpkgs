{ lib
, buildPythonPackage
, fetchFromGitHub
, matrix-nio
, pillow
, markdown
, cryptography-fernet-wrapper
, toml
}:

buildPythonPackage rec {
  pname = "simplematrixbotlib";
  version = "2.7.0";

  src = fetchFromGitHub {
    owner = "i10b";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-AwNiX97scv+rfaPmqs/MV1NsQq5DJ105oV4Fm3OqzfY=";
  };

  propagatedBuildInputs = [
    matrix-nio
    pillow
    markdown
    cryptography-fernet-wrapper
    toml
  ];

  meta = with lib; {
    description = "An easy to use bot library for the Matrix ecosystem written in Python.";
    homepage = "https://github.com/i10b/simplematrixbotlib";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ alyaeanyx ];
  };
}
