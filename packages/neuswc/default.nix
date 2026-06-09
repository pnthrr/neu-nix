{
  lib,
  meson,
  pkg-config,
  wayland-scanner,
  libdrm,
  neuwld,
  wayland,
  xwayland,
  wayland-protocols,
  pixman,
  udev,
  ninja,
  fontconfig,
  libxkbcommon,
  libinput,
  libxcb,
  libxcb-wm,
  stdenv,
  fetchFromSourcehut,
  patches ? [ ],
  xwaylandSupport ? true,
  extra ? true,
  example ? false,
  evdev-keyboard ? "/dev/input/event0",
  evdev-pointer ? "/dev/input/event1",
}:
stdenv.mkDerivation {
  pname = "neuswc";
  version = "0.0";

  src = fetchFromSourcehut {
    owner = "~shrub900";
    repo = "neuswc";
    rev = "975ad56221d4545bdd44d14fdd4cac796de207d9";
    hash = "sha256-2C0WsK/Rg5YS7bFzKQzFHn1h8SlWKnHbSak3THWzxbs=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    wayland-scanner
    libdrm
  ];

  buildInputs = [
    neuwld
    wayland
    wayland-protocols
    pixman
    libdrm
    udev
    libxkbcommon
    libinput
    fontconfig
  ]
  ++ lib.optionals xwaylandSupport [
    xwayland
    libxcb
    libxcb-wm
  ];

  mesonAutoFeatures = "auto";

  mesonFlags = [
    "-Dextra=${lib.boolToString extra}"
    "-Dexample=${lib.boolToString example}"
    "-Devdev-keyboard=${evdev-keyboard}"
    "-Devdev-pointer=${evdev-pointer}"
  ];

  inherit patches;

  postInstall = ''
    mkdir -p $out/include
    wayland-scanner client-header $src/protocol/swc.xml $out/include/swc-client-protocol.h
  '';

  meta = {
    description = "Fork of swc for hevel window manager";
    homepage = "https://git.sr.ht/~shrub900/neuswc";
    license = lib.licenses.isc;
    mainProgram = "swc-launch";
  };
}
