{
  lib,
  fetchFromSourcehut,
  stdenv,
  pixman,
  wayland,
  wayland-scanner,
  pkg-config,
  libdrm,
  neuwld,
  neuswc,
  fontconfig,
}:
stdenv.mkDerivation {
  pname = "mojito";
  version = "0.0";

  src = fetchFromSourcehut {
    owner = "~dlm";
    repo = "mojito";
    rev = "713662f2f7620a74df59bdfa17a1d8d4715b9562";
    hash = "sha256-OYVRc0rh+yoIXNo3kLt+G8ulvxx8W8foOUn+YdAou6U=";
  };

  nativeBuildInputs = [
    pkg-config
    wayland-scanner
  ];

  buildInputs = [
    pixman
    wayland
    libdrm
    neuwld
    neuswc
    fontconfig
    wayland
  ];

  makeFlags = [
    "PREFIX=$(out)"
    "DESTDIR=$(out)"
  ];

  meta = {
    description = "A featherweight, lime-scented (and somewhat alcoholic) bar for Wayland";
    homepage = "https://git.sr.ht/~dlm/mojito";
    license = lib.licenses.isc;
  };
}
