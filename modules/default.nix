{ pkgs, lib }:
{
  nixos = import ./nixos {
    inherit pkgs lib;
  };
}
