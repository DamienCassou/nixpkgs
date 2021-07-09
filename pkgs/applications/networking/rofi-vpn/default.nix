{ stdenv
, lib
, fetchFromGitLab
, substituteAll
, makeWrapper
, rofi-unwrapped
, networkmanager
}:

stdenv.mkDerivation rec {
  pname = "rofi-vpn";
  version = "0.2.0";

  src = fetchFromGitLab {
    owner = "DamienCassou";
    repo = pname;
    rev = "v${version}";
    sha256 = "04jcfb2jy8yyrk4mg68krwh3zb5qcyj1aq1bwk96fhybrq9k2hhp";
  };

  installPhase = ''
    runHook preInstall

    install -D --target-directory=$out/bin/ ./rofi-vpn

    wrapProgram $out/bin/rofi-vpn \
      --prefix PATH ":" ${lib.makeBinPath [ rofi-unwrapped networkmanager ]}

    runHook postInstall
  '';

  nativeBuildInputs = [ makeWrapper ];

  meta = with lib; {
    description = "An emoji selector plugin for Rofi";
    homepage = "https://github.com/Mange/rofi-emoji";
    license = licenses.mit;
    maintainers = with maintainers; [ cole-h ];
    platforms = platforms.linux;
  };
}
