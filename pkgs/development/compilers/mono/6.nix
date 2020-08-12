{ callPackage, Foundation, libobjc, python38 }:

callPackage ./generic.nix ({
  inherit Foundation libobjc;
  version = "6.10.0.104";
  srcArchiveSuffix = "tar.xz";
  sha256 = "0b1kgqqpk3kzlmzn2panh7jmkp43k196pml4hfnyzljjl9qfpmmq";
  enableParallelBuilding = true;
  python = python38;
})
