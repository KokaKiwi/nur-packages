{ pkgs, lib, ... }:
let
  callPackage = lib.callPackageWith (pkgs // final // {
    inherit callPackage;
  });

  mergeAttrsList = let
    mergeAttrsList' = lib.foldl lib.mergeAttrs { };
  in lib.mergeAttrsList or mergeAttrsList';

  importSub = prefix: attrs: lib.mapAttrs (
    name: {
      _file ? null,
      _subPath ? if _file != null
        then "${name}/${_file}"
        else name,
        _path ? lib.path.append prefix _subPath,
      _attr ? null,
      _common ? null,
      ...
    }@args: let
      args' =
        builtins.removeAttrs args [ "_file" "_subPath" "_path" "_attr" "_common" ]
        // lib.optionalAttrs (_common != null) {
          _common = callPackage ./common/${_common}.nix { };
        };
      package = callPackage _path args';
    in if _attr != null then package.${_attr} else package
  ) attrs;

  applications = importSub ./applications {
    agree = { };
    aura = { };
    enquirer = { };
    ferdium = {
      pnpm = pkgs.pnpm_9;
      nodejs = pkgs.nodejs_20;
    };
    go-mod-upgrade = { };
    imhex = { };
    lddtree = { };
    ots-cli = {
      _common = "ots";
      buildGoModule = pkgs.buildGo123Module;
    };
    sccache = { };
    streampager = { };
    tumelune = { };
    vanta-agent = { };
  };

  development = importSub ./development {
  };

  servers = importSub ./servers {
    cryptpad = { };
    freenginx = {
      modules = with pkgs.nginxModules; [ moreheaders ];
    };
    ots = {
      _common = "ots";
      buildGoModule = pkgs.buildGo123Module;
    };
    piped-proxy = { };
  };

  final = mergeAttrsList [
    applications
    development
    servers
  ];
in final
