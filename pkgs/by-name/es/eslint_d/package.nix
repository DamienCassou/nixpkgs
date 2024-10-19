{ lib, buildNpmPackage, fetchFromGitHub, eslint_d, testers }:

buildNpmPackage rec {
  pname = "eslint_d";
  version = "14.2.0";

  src = fetchFromGitHub {
    owner = "mantoni";
    repo = "eslint_d.js";
    rev = "v${version}";
    hash = "sha256-Ta9wionfqJ4bL+VdK9ii08y0353bHlBCvCfoFs2ovZY=";
  };

  npmDepsHash = "sha256-LN1jZYuWsCi7LKO5o9lYsa//MGDFpZTLn1xtG5IdUZU=";

  dontNpmBuild = true;

  passthru.tests.version = testers.testVersion { package = eslint_d; version = src.rev; };

  meta = with lib; {
    description = "Makes eslint the fastest linter on the planet";
    homepage = "https://github.com/mantoni/eslint_d.js";
    license = licenses.mit;
    maintainers = [ maintainers.ehllie ];
    mainProgram = "eslint_d";
  };
}
