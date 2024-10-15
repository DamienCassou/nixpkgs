{ lib, buildNpmPackage, fetchFromGitHub }:

buildNpmPackage rec {
  pname = "copilot-node-server";
  version = "1.27.0";

  src = fetchFromGitHub {
    owner = "jfcherng";
    repo = "copilot-node-server";
    rev = "${version}";
    hash = "sha256-Ds2agoO7LBXI2M1dwvifQyYJ3F9fm9eV2Kmm7WITgyo=";
  };

  npmDepsHash = "sha256-tbcNRQBbJjN1N5ENxCvPQbfteyxTbPpi35dYmeUc4A4=";

  postPatch = ''
    cp ${./package-lock.json} package-lock.json
  '';

  preInstall = ''
    # `npmInstallHook` requires a `node_modules/` folder but `npm
    # install` doesn't generate one because the project has no
    # dependencies:
    mkdir node_modules/
  '';

  forceEmptyCache = true;
  dontNpmBuild = true;

  meta = with lib; {
    description = "Copilot Node.js server";
    homepage = src.meta.homepage;
    license = licenses.unfree; # I don't know: https://github.com/jfcherng/copilot-node-server/blob/main/LICENSE.md
    maintainers = with maintainers; [ DamienCassou ];
    mainProgram = "copilot-node-server";
  };
}
