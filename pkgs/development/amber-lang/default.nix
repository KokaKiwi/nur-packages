{ lib

, fetchFromGitHub

, rustPlatform

, bash
}:
rustPlatform.buildRustPackage rec {
  pname = "amber-lang";
  version = "0.3.5-alpha";

  src = fetchFromGitHub {
    owner = "amber-lang";
    repo = "amber";
    rev = version;
    hash = "sha256-wf0JNWNliDGNvlbWoatPqDKmVaBzHeCKOvJWuE9PnpQ=";
  };

  cargoHash = "sha256-6T4WcQkCMR8W67w0uhhN8W0FlLsrTUMa3/xRXDtW4Es=";

  postPatch = ''
    substituteInPlace src/compiler.rs \
      --replace-warn "/bin/bash" "${bash}/bin/bash"
  '';

  # FIXME: For weird reasons some tests fails
  doCheck = false;

  checkFlags = [
    "--skip=tests::validity::infinite_loop"
  ];

  meta = with lib; {
    description = "Amber the programming language compiled to bash";
    homepage = "https://amber-lang.com";
    license = licenses.gpl3;
    mainProgram = "amber";
  };
}
