{ pkgs, callPackage }:
{
  cryptpad = callPackage ./cryptpad {};
  ferdium = callPackage ./ferdium {};
  paru = callPackage ./paru {};
}
