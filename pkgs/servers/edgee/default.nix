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
  version = "1.2.4";

  src = fetchFromGitHub {
    owner = "edgee-cloud";
    repo = "edgee";
    tag = "v${version}";
    hash = "sha256-iOM6n8/PxHvRa7UTFNGxzkpnq0Mi9P7pFQxR0EFdDO8=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-ay1UuuhPx80afW5Y0NZqBPITvDsVYWfbunJ4i0Jlu14=";

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
