{
  lib,
  rustPlatform,
  rustc,
  fetchFromGitHub,
  pkg-config,
  openssl,
  zstd,
}:
rustPlatform.buildRustPackage rec {
  pname = "edgee";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "edgee-cloud";
    repo = "edgee";
    tag = "v${version}";
    hash = "sha256-eP46xQHH21kGaEsKoi6r1OX8Ato7tEImt5i3LI0Ob6U=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-lkDWvER7KpM8yt8ItwNH0gLTuM1xEQqtvJ0iuIhePlU=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
    zstd
  ];

  buildAndTestSubdir = "crates/cli";

  env = {
    OPENSSL_NO_VENDOR = true;
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  meta = {
    description = "The full-stack edge platform for your edge oriented applications";
    homepage = "https://github.com/edgee-cloud/edgee";
    changelog = "https://github.com/edgee-cloud/edgee/releases/tag/v${version}";
    license = lib.licenses.asl20;
    mainProgram = "edgee";
    broken = lib.versionOlder rustc.version "1.83.0";
  };
}
