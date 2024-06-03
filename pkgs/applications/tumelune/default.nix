{ lib

, fetchzip

, rustPlatform

, pkg-config
, zstd
}:
rustPlatform.buildRustPackage rec {
  pname = "tumelune";
  version = "0.16.0";

  src = fetchzip {
    url = "https://fedi.doom.solutions/tumelune/files/tumelune-v${version}-source.zip";
    hash = "sha256-7Z6K6NHpgQ303Kyss8lwq0aiGq7rOSvJEBA/fIFjOlg=";
  };

  cargoHash = "sha256-u15Ykx9McFVvVECqKB9O5aWnrFPEabn7x106ogW/twk=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ zstd ];

  env.ZSTD_SYS_USE_PKG_CONFIG = true;

  meta = with lib; {
    description = "A simple program to browse and search in twitter and mastodon archives";
    homepage = "https://fedi.doom.solutions/tumelune/";
    mainProgram = "tumelune";
  };
}
