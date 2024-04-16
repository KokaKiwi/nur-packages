{ pkgs ? import <nixpkgs> {}
}: let
  inherit (pkgs) callPackage;
in {
  cryptpad = callPackage ./cryptpad {};
}
