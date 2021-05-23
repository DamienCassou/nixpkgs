{ lib
, stdenv
, fetchurl
, fetchpatch
, meson
, ninja
, pkg-config
, vala
, cmake
, libarchive
, glib
, grilo
, libxml2
, gtk3
, libhandy
, libmanette
, retro-gtk
, librsvg
, libsoup
, sqlite
, desktop-file-utils
, appstream-glib
, python3
, tracker
, wrapGAppsHook
}:

stdenv.mkDerivation rec {
  pname = "gnome-games";
  version = "40.0";

  src = fetchurl {
    url = "mirror://gnome/sources/gnome-games/${lib.versions.major version}/${pname}-${version}.tar.xz";
    sha256 = "03yzd97kpkjdzfqp8qx3mqnf9347yk830njam2q78ai9i4zl3k9j";
  };

  patches = [
    # https://gitlab.gnome.org/GNOME/gnome-games/-/merge_requests/424
    (fetchpatch {
      name   = "gnome-games-port-to-tracker3.patch";
      url    = "https://gitlab.gnome.org/GNOME/gnome-games/-/commit/d38e93160a8e16776bb1fdc46f547365d3f2c9ee.patch";
      sha256 = "0k7g7p8spdnvzfg6p9rqbvj5df5yx7wgz0m8w963ls0bv00fp0fc";
    })
  ];

  nativeBuildInputs = [
    meson pkg-config ninja vala cmake glib libxml2 grilo gtk3 libhandy libmanette retro-gtk librsvg
    libsoup sqlite libarchive tracker desktop-file-utils appstream-glib python3 wrapGAppsHook
  ];

  preInstall = ''
    patchShebangs ../build-aux/post_install.py
  '';

  meta = with lib; {
    description = "Simple game launcher for GNOME";
    longDescription = ''
      Just as your music player does, Games shows you all of your
      installed games with their cover art, even Steam and retro
      games, and sorts them by developer or platform.

      Many legacy game platforms are supported and tightly integrated
      into Games' interface. Simply select your preferred video
      filter, grab your gamepad and enjoy your game.

      When you leave an integrated game, your progress is
      automatically saved so you can restart where you left off.
    '';
    homepage = "https://wiki.gnome.org/Apps/Games";
    changelog = "https://gitlab.gnome.org/GNOME/gnome-games/-/blob/master/NEWS";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.DamienCassou ];
    platforms = platforms.all;
  };
}
