{
  fetchFromGitHub,
  lib,
  stdenvNoCC,
  ...
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "emacs-anywhere";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "nohzafk";
    repo = "emacs-anywhere";
    rev = "v${finalAttrs.version}";
    sha256 = "sha256-ZHzJfABFnpquIsP6UknusPeYmx20p090JyvVMhJ/OOs=";
  };

  installPhase = ''
    cp -R EmacsAnywhere.spoon/ $out/
  '';

  meta = {
    description = "Edit text from any macOS application in Emacs";
    homepage = finalAttrs.src.meta.homepage;
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ DamienCassou ];
  };
})
