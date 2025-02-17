{
  lib,
  aiofiles,
  buildPythonPackage,
  cryptography,
  fetchFromGitHub,
  protobuf,
  pythonOlder,
  setuptools,
}:

buildPythonPackage rec {
  pname = "androidtvremote2";
  version = "0.1.2";
  pyproject = true;

  disabled = pythonOlder "3.10";

  src = fetchFromGitHub {
    owner = "tronikos";
    repo = "androidtvremote2";
    tag = "v${version}";
    hash = "sha256-4iVM7BCqOFHrW2BvPakXxp3MfZa+WlB7g/ix239NldE=";
  };

  build-system = [ setuptools ];

  dependencies = [
    aiofiles
    cryptography
    protobuf
  ];

  pythonImportsCheck = [ "androidtvremote2" ];

  # Module only has a dummy test
  doCheck = false;

  meta = with lib; {
    description = "Library to interact with the Android TV Remote protocol v2";
    homepage = "https://github.com/tronikos/androidtvremote2";
    changelog = "https://github.com/tronikos/androidtvremote2/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
  };
}
