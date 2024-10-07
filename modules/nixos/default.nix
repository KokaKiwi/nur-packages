{ lib, ... }:
let
  modules = {
    networking = {
      netns = import ./networking/netns.nix;
      shadowsocks-rust = import ./networking/shadowsocks-rust.nix;
    };
    services = {
      pueue = import ./services/pueue.nix;
      qbittorrent = import ./services/qbittorrent.nix;
    };
  };

  all-modules = lib.concat [
    (lib.attrValues modules.networking)
    (lib.attrValues modules.services)
  ];
in modules // {
  inherit all-modules;
}
