{
  lib,
  async-timeout,
  buildPythonPackage,
  cython,
  fetchFromGitHub,
  gssapi,
  kafka-python,
  lz4,
  packaging,
  python-snappy,
  pythonOlder,
  setuptools,
  zlib,
  zstandard,
}:

buildPythonPackage rec {
  pname = "aiokafka";
  version = "0.11.0";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "aio-libs";
    repo = "aiokafka";
    rev = "refs/tags/v${version}";
    hash = "sha256-CeEPRCsf2SFI5J5FuQlCRRtlOPcCtRiGXJUIQOAbyCc=";
  };

  build-system = [
    cython
    setuptools
  ];

  buildInputs = [ zlib ];

  dependencies = [
    async-timeout
    kafka-python
    packaging
  ];

  optional-dependencies = {
    snappy = [ python-snappy ];
    lz4 = [ lz4 ];
    zstd = [ zstandard ];
    gssapi = [ gssapi ];
  };

  # Checks require running Kafka server
  doCheck = false;

  pythonImportsCheck = [ "aiokafka" ];

  meta = with lib; {
    description = "Kafka integration with asyncio";
    homepage = "https://aiokafka.readthedocs.org";
    changelog = "https://github.com/aio-libs/aiokafka/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = [ ];
  };
}
