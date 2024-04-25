{ pkgs, callPackage }:
let
  inherit (pkgs) lib;

  importSub = prefix: attrs: lib.flip lib.mapAttrs attrs (
    name: args: let
      path = lib.path.append prefix name;
    in callPackage path args
  );

  applications = importSub ./applications {
    ferdium = { };
    paru = { };
  };

  servers = importSub ./servers {
    cryptpad = { };
  };

in lib.mergeAttrsList [
  applications
  servers
]
