{
  lib,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages,
}:
buildDotnetModule rec {
  pname = "steam-token-dumper";
  version = "2024.10.12";

  src = fetchFromGitHub {
    owner = "SteamDatabase";
    repo = "SteamTokenDumper";
    tag = version;
    hash = "sha256-hyB8e5ofYEA8btAkZCDgvwDNwsxEJ3j2sYZ9d8ioOPE=";
  };

  projectFile = "SteamTokenDumper.csproj";
  nugetDeps = ./deps.json;

  dotnet-sdk = dotnetCorePackages.sdk_9_0;
  dotnet-runtime = dotnetCorePackages.runtime_8_0;

  executables = [ "SteamTokenDumper" ];

  meta = {
    description = "Submit users' PICS access tokens to SteamDB";
    homepage = "https://steamdb.info/tokendumper";
    repository = "https://github.com/SteamDatabase/SteamTokenDumper";
    license = lib.licenses.mit;
    mainProgram = "steam-token-dumper";
    platforms = lib.platforms.all;
  };
}
