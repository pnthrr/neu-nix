{
  lib,
  stdenv,
  fetchFromSourcehut,
  pkg-config,
  neuswc,
  wayland,
  pixman,
  libxkbcommon,
  libinput,
  libspng,
}:
stdenv.mkDerivation {
  pname = "howl";
  version = "0.1.0";
  src = fetchFromSourcehut {
    domain = "sr.ht";
    owner = "~wf";
    repo = "howl";
    rev = "d94c8fa497c130cf2fd0f0ab3e684fdfceceebb8";
    hash = "sha256-Ph73YmKlIUj2USRWqGjNtYbz1AJmKKC2eZpFWcUhGKU=";
  };

  nativeBuildInputs = [
    pkg-config
  ];
  buildInputs = [
    neuswc
    wayland
    pixman
    libxkbcommon
    libinput
    libspng
  ];

  preBuild = ''
    export NIX_LDFLAGS="$NIX_LDFLAGS $(pkg-config --libs wayland-server xkbcommon)"
  '';

  makeFlags = [ "PREFIX=$(out)" ];

  meta = {
    description = "A small Wayland compositor (howl) and its IPC client (howlc)";
    homepage = "https://codeberg.org/wf/howl";
    license = lib.licenses.isc;
    mainProgram = "howl";
  };
}
